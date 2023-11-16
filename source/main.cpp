#include <iostream>
#include <string>

auto to_hex = [](unsigned char c) -> char
{
    if (c < 10)
    {
        return c + 48;
    }
    else
    {
        return c + 55;
    }
};

int main()
{
    unsigned char mac[6] = {0xa0, 0xa0, 0xb0, 0x03, 0xa0, 0xd0};
    unsigned short sum = 0;

    for (int i = 0; i < 6; i++)
    {
        sum += mac[i];
    }
    // print sum
    std::cout << "Sum: " << sum << std::endl;
    // to string
    std::string macString = "";
    // loop through all bytes
    for (int i = 0; i < 6; i++)
    {
        // to HEX
        macString += to_hex(mac[i] / 16);
        macString += to_hex(mac[i] % 16);

        // add colon
        macString += ":";
    }
    // remove last colon
    macString.pop_back();
    // print mac address
    std::cout << "MAC: " << macString << std::endl;

    auto sum_to_hex = [](unsigned short s) -> std::string
    {
        std::string hex = "";
        // loop through all bytes
        for (int i = 0; i < 2; i++)
        {
            // to HEX
            unsigned char c = s % 256;
            hex += to_hex(c % 16);
            hex += to_hex(c / 16);
            // shift right
            s /= 256;
        }
        // reverse string
        std::reverse(hex.begin(), hex.end());
        // return hex
        return hex;
    };

    // print sum as hex
    std::cout << "Sum as HEX: " << sum_to_hex(sum) << std::endl;
}