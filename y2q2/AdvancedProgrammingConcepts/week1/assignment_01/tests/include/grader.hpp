#ifndef INCLUDED_INCLUDE_GRADER_HPP
#define INCLUDED_INCLUDE_GRADER_HPP
#include "doctest.h"
#include <mutex>
#include <array>
#include <string_view>
#include <bit>
#include <unordered_map>
#include <numeric>

namespace sax::testing
{
    std::string_view failure_flags_to_string(int flags){
        using namespace std::literals::string_view_literals;
        std::array<std::string_view, 11> reasons{
            "None"sv,
            "AssertFailure"sv,
            "Exception"sv,
            "Crash"sv,
            "TooManyFailedAsserts"sv,
            "Timeout"sv,
            "ShouldHaveFailedButDidnt"sv,
            "ShouldHaveFailedAndDid"sv,
            "DidntFailExactlyNumTimes"sv,
            "FailedExactlyNumTimes"sv,
            "CouldHaveFailedAndDid"sv
        };

        auto flag2index = [](unsigned flag) { return sizeof(flag) *  8 - static_cast<std::size_t>(std::countl_zero(flag)); };
        return reasons[flag2index(static_cast<unsigned>(flags))];
    }

    struct TestCaseScore
    {
        std::string_view name;
        float max_points{ 0 };
        float earned_points{ 0 };

        using HashType = decltype([](auto&& tcs){
           auto hname = std::hash<std::string_view>{}(tcs.name);
            auto hkey = std::hash<float>{}(tcs.max_points);
            return hname ^ (hkey << 1);
        });

        bool operator==(const TestCaseScore& other) const {
            return name == other.name && max_points == other.max_points;
        }
    };

    struct ScoresBase
    {
        std::unordered_map<std::string_view, TestCaseScore> test_cases{};

        ScoresBase(std::initializer_list<TestCaseScore> tcs){
            for (const auto& tc : tcs){
                test_cases.emplace(tc.name, tc);
            }
        }

        bool add(TestCaseScore tcs) {
            return test_cases.emplace(tcs.name, std::move(tcs)).second;
        }

        template <typename...Args>
        bool add(Args&&...args){
            return add(TestCaseScore{ std::forward<Args>(args)... });
        }

        TestCaseScore& operator[](std::string_view name){
            return test_cases.at(name);
        }

        const TestCaseScore& operator[](std::string_view name) const {
            return test_cases.at(name);
        }

        float max_points() const {
            return std::transform_reduce(
                test_cases.begin(), test_cases.end(),
                0.0f,
                std::plus<>(),
                [](const auto& pair){ return pair.second.max_points; }
            );
        }

        float score() const {
            return std::transform_reduce(
                test_cases.begin(), test_cases.end(),
                0.0f,
                std::plus<>(),
                [](const auto& pair){ return pair.second.earned_points; }
            );
        }
    };

    template <typename Scores>
    struct Grader : public doctest::IReporter
    {
        // caching pointers/references to objects of these types - safe to do
        std::ostream&         out;
        const doctest::ContextOptions& opt;
        const doctest::TestCaseData*   tc;
        std::mutex            mutex;
        Scores                scores{};

        // constructor has to accept the ContextOptions by ref as a single argument
        Grader(const doctest::ContextOptions& in)
                : out(*in.cout)
                , opt(in) {}

        void report_query(const doctest::QueryData& /*in*/) override {}

        void test_run_start() override
         {
            std::cerr << "=== Grading Started ===\n";
         }

        void test_run_end(const doctest::TestRunStats& /*in*/) override {

            out << "\n\n=== Grading Summary ===\n";
            out << "Total points: " << scores.score() << " / " << scores.max_points() << '\n';
            out << "======================\n";
        }

        void test_case_start(const doctest::TestCaseData& in) override { 
            tc = &in;
        }

        // called when a test case is reentered because of unfinished subcases
        void test_case_reenter(const doctest::TestCaseData& /*in*/) override {}

        void test_case_end(const doctest::CurrentTestCaseStats& stats) override {

            auto name = remove_scenario_prefix(tc->m_name);
            scores[name].earned_points = stats.testCaseSuccess ? scores[name].max_points : 0.0f;


            std::cerr << "+ " << std::setw(30) << std::left << name 
                      << "  " << std::setw(6) << std::left << (stats.testCaseSuccess ? "OK" : "NOK") 
                      << std::setw(10) << std::left << scores[name].earned_points << '\n';
            // std::cerr << " Failure flags: " << failure_flags_to_string(stats.failure_flags) << '\n';
        }

        void test_case_exception(const doctest::TestCaseException& /*in*/) override {}

        void subcase_start(const doctest::SubcaseSignature& /*in*/) override {
            std::lock_guard<std::mutex> lock(mutex);
        }

        void subcase_end() override {
            std::lock_guard<std::mutex> lock(mutex);
        }

        void log_assert(const doctest::AssertData& in) override {
            // don't include successful asserts by default - this is done here
            // instead of in the framework itself because doctest doesn't know
            // if/when a reporter/listener cares about successful results
            if(!in.m_failed && !opt.success)
                return;

            // make sure there are no races - this is done here instead of in the
            // framework itself because doctest doesn't know if reporters/listeners
            // care about successful asserts and thus doesn't lock a mutex unnecessarily
            std::lock_guard<std::mutex> lock(mutex);

            // ...
        }

        void log_message(const doctest::MessageData& /*in*/) override {
            // messages too can be used in a multi-threaded context - like asserts
            std::lock_guard<std::mutex> lock(mutex);

            // ...
        }

        void test_case_skipped(const doctest::TestCaseData& /*in*/) override {}

        private:

            std::string_view remove_scenario_prefix(std::string_view test_name) {
                const std::string_view prefix = "  Scenario: ";
                if (test_name.starts_with(prefix)) {
                    return test_name.substr(prefix.size());
                }

                std::cerr << "Warning: Test case name does not start with expected prefix '" << prefix << "': " << std::quoted(test_name) << '\n';
                return test_name;
            }
    };
}

#endif /* INCLUDED_INCLUDE_GRADER_HPP */
