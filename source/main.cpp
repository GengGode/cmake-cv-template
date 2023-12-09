#include <iostream>
#include <string>
#include <opencv2/opencv.hpp>

int main()
{
    cv::Mat image = cv::Mat(100, 100, CV_8UC3, cv::Scalar(0, 0, 0));
    std::cout << "Image size: " << image.size() << std::endl;
}