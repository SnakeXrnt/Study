using System;
using MySql.Data.MySqlClient;

namespace Week3
{
    internal static class ReaderExtensions
    {
        public static bool IsDBNull(this MySqlDataReader rdr, string name)
        {
            var idx = rdr.GetOrdinal(name);
            return rdr.IsDBNull(idx);
        }

        public static string? GetString(this MySqlDataReader rdr, string name)
        {
            var idx = rdr.GetOrdinal(name);
            return rdr.IsDBNull(idx) ? null : rdr.GetString(idx);
        }

        public static int GetInt32(this MySqlDataReader rdr, string name)
        {
            var idx = rdr.GetOrdinal(name);
            if (rdr.IsDBNull(idx)) return 0;
            // Use Convert.ToInt32 to handle numeric types returned by MySQL provider
            return Convert.ToInt32(rdr.GetValue(idx));
        }

        public static double? GetDoubleNullable(this MySqlDataReader rdr, string name)
        {
            var idx = rdr.GetOrdinal(name);
            if (rdr.IsDBNull(idx)) return null;
            return Convert.ToDouble(rdr.GetValue(idx));
        }

        public static object? GetValue(this MySqlDataReader rdr, string name)
        {
            var idx = rdr.GetOrdinal(name);
            return rdr.IsDBNull(idx) ? null : rdr.GetValue(idx);
        }
    }
}