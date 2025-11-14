this is the basic implementation of me overdoing the assignment

i bascially want it to be like minicom, but i dont have time to implement some more cool stuff (like ctrl-A Z), etc

```c#

using System;
using System.IO.Ports;

class Program {
    

    static void Main() {
        while(true){

            Console.Clear();
            CheckPort();
            Console.WriteLine("type the port oyu want to read (/dev/ttyACM0) : ");
            string port_name = Console.ReadLine();
            RW_func(port_name);
        } 
    }

    static void RW_func(string portName) {
        int baudRate = 9600;


        

        using (SerialPort port = new SerialPort(portName, baudRate)) {
            port.NewLine = "\n";

            port.DtrEnable = true;
            port.RtsEnable = true;

            port.Open();
            Console.WriteLine("connected to " + portName);
            Console.WriteLine("type (q) to go back to main menu ");

            Thread readThread = new Thread(() => {
                while (true) {
                    try {
                        string line = port.ReadLine();
                        line = line.Trim();
                        Console.WriteLine("[From SC "+ portName + "]  | " + line);
                    }
                    catch {
                    break;
                    }
                }
            });
            
            readThread.Start();

            while(true) {
                string input = Console.ReadLine();

                if (input == null) {
                    continue;
                }

                if (input.ToLower() == "q") {     // user wants to exit
                    Console.WriteLine("closing port...");
                    break;                       // break out of the write loop
                }

                port.WriteLine(input);

                
                
            }

            port.Close();
            
        }
    }

    static void CheckPort() {
        string[] ports = SerialPort.GetPortNames();
        Console.WriteLine("Available serial potr: ");

        foreach (string p in ports) {
            Console.WriteLine(p);
        }

    } 

}
```