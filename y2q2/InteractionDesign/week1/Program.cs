using System;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading;

namespace ConsoleSerialSelect
{
    class Program
    {
        static void Main()
        {
            var app = new App();
            app.Run();
        }
    }

    class App
    {
        private int _selectedIndex = 0;
        private string[] _ports = Array.Empty<string>();
        private bool _running = true;

        public void Run()
        {
            if (!IsInteractive())
            {
                RunSimple();
                return;
            }

            bool origCursorVisible = true;
            try { origCursorVisible = Console.CursorVisible; } catch { }
            SafeSetCursorVisible(false);

            try
            {
                while (_running)
                {
                    _ports = GetPorts();
                    if (_selectedIndex >= _ports.Length) _selectedIndex = Math.Max(0, _ports.Length - 1);

                    DrawMenu();

                    var key = SafeReadKey();
                    if (key == null) continue;

                    switch (key.Value.Key)
                    {
                        case ConsoleKey.Q:
                        case ConsoleKey.Escape:
                            _running = false;
                            break;
                        case ConsoleKey.R:
                            break; // refresh list
                        case ConsoleKey.UpArrow:
                            if (_ports.Length > 0) _selectedIndex = (_selectedIndex - 1 + _ports.Length) % _ports.Length;
                            break;
                        case ConsoleKey.DownArrow:
                            if (_ports.Length > 0) _selectedIndex = (_selectedIndex + 1) % _ports.Length;
                            break;
                        case ConsoleKey.Enter:
                            if (_ports.Length > 0)
                                ConnectAndStream(_ports[_selectedIndex]);
                            break;
                    }
                }
            }
            finally
            {
                SafeSetCursorVisible(origCursorVisible);
                SafeClear();
            }
        }

        private void RunSimple()
        {
            var ports = GetPorts();
            if (ports.Length == 0)
            {
                Console.WriteLine("No serial ports found.");
                return;
            }

            Console.WriteLine("Available serial ports:");
            for (int i = 0; i < ports.Length; i++)
                Console.WriteLine($"[{i}] {ports[i]}");

            Console.Write("Select index: ");
            if (!int.TryParse(Console.ReadLine(), out int index) || index < 0 || index >= ports.Length)
            {
                Console.WriteLine("Invalid selection.");
                return;
            }

            ConnectAndStream(ports[index], showMenuHint: false);
        }

        private static string[] GetPorts()
        {
            var all = SerialPort.GetPortNames()
                                .OrderBy(s => s, StringComparer.Ordinal)
                                .ToArray();

            if (Environment.OSVersion.Platform == PlatformID.Unix)
            {
                var filtered = all.Where(p => p.StartsWith("/dev/ttyACM") || p.StartsWith("/dev/ttyUSB"))
                                  .ToArray();
                return filtered.Length > 0 ? filtered : all;
            }
            return all;
        }

        private void DrawMenu()
        {
            SafeSetCursorPosition(0, 0);
            Console.WriteLine("Serial Port Selector");
            Console.WriteLine("====================");
            if (_ports.Length == 0)
            {
                Console.WriteLine("No ports found");
                Console.WriteLine();
                Console.WriteLine("Hints:");
                Console.WriteLine(" - Plug in your Pico");
                Console.WriteLine(" - Press r to refresh");
                Console.WriteLine(" - Press q to quit");
                ClearBelow();
                return;
            }

            Console.WriteLine("Use ↑ ↓ to navigate, Enter to connect, r to refresh, q to quit");
            Console.WriteLine();

            for (int i = 0; i < _ports.Length; i++)
            {
                if (i == _selectedIndex)
                {
                    var oldFg = Console.ForegroundColor;
                    var oldBg = Console.BackgroundColor;
                    Console.BackgroundColor = ConsoleColor.DarkCyan;
                    Console.ForegroundColor = ConsoleColor.White;
                    Console.WriteLine($"> {_ports[i]}");
                    Console.ForegroundColor = oldFg;
                    Console.BackgroundColor = oldBg;
                }
                else
                {
                    Console.WriteLine($"  {_ports[i]}");
                }
            }
            ClearBelow();
        }

        private void ClearBelow()
        {
            try
            {
                int currentLine = Console.CursorTop;
                int linesToClear = Math.Max(0, Console.BufferHeight - currentLine - 1);
                for (int i = 0; i < linesToClear; i++)
                    Console.WriteLine(new string(' ', Math.Max(1, Console.BufferWidth - 1)));
                SafeSetCursorPosition(0, currentLine);
            }
            catch { }
        }

        private void ConnectAndStream(string portName, bool showMenuHint = true)
        {
            SafeClear();
            Console.WriteLine($"Connecting to {portName} at 115200");
            using var sp = new SerialPort(portName, 115200)
            {
                Parity = Parity.None,
                DataBits = 8,
                StopBits = StopBits.One,
                Handshake = Handshake.None,
                DtrEnable = true,
                RtsEnable = true,
                ReadTimeout = 200,
                NewLine = "\r\n"
            };

            try
            {
                sp.Open();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to open port: {ex.Message}");
                Console.WriteLine("Press any key to return");
                SafeReadKey(true);
                return;
            }

            Console.WriteLine("Connected");
            Console.WriteLine("Press q to disconnect");
            Console.WriteLine();

            var sb = new StringBuilder();
            var stop = false;

            var reader = new Thread(() =>
            {
                while (!stop)
                {
                    try
                    {
                        int n = sp.BytesToRead;
                        if (n > 0)
                        {
                            var buf = new byte[n];
                            sp.Read(buf, 0, n);
                            for (int i = 0; i < n; i++)
                            {
                                char c = (char)buf[i];
                                if (c == '\n' || c == '\r')
                                {
                                    if (sb.Length > 0)
                                    {
                                        Console.WriteLine(sb.ToString());
                                        sb.Clear();
                                    }
                                }
                                else
                                {
                                    sb.Append(char.IsControl(c) ? '.' : c);
                                }
                            }
                        }
                        else
                        {
                            Thread.Sleep(5);
                        }
                    }
                    catch (TimeoutException) { }
                    catch { }
                }
            })
            { IsBackground = true };

            reader.Start();

            while (true)
            {
                var key = SafeReadKey();
                if (key.HasValue && (key.Value.Key == ConsoleKey.Q || key.Value.Key == ConsoleKey.Escape))
                    break;
                Thread.Sleep(10);
            }

            stop = true;
            try { reader.Join(500); } catch { }
            try { sp.Close(); } catch { }

            Console.WriteLine();
            Console.WriteLine("Disconnected. Press any key to return");
            SafeReadKey(true);
            if (showMenuHint) SafeClear();
        }

        // Helpers for fragile console operations

        private static bool IsInteractive()
        {
            try
            {
                return !Console.IsOutputRedirected && !Console.IsInputRedirected;
            }
            catch { return false; }
        }

        private static void SafeSetCursorVisible(bool visible)
        {
            try { Console.CursorVisible = visible; } catch { }
        }

        private static void SafeSetCursorPosition(int left, int top)
        {
            try { Console.SetCursorPosition(left, top); } catch { }
        }

        private static void SafeClear()
        {
            try { Console.Clear(); } catch { }
        }

        private static ConsoleKeyInfo? SafeReadKey(bool intercept = true)
        {
            try
            {
                if (!Console.KeyAvailable) return null;
                return Console.ReadKey(intercept);
            }
            catch
            {
                return null;
            }
        }
    }
}
