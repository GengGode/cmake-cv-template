
add_executable(cmake_template main.cpp)

include_directories(${OPENCV_INCLUDE_DIRS})
message(STATUS "OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}")
target_link_libraries(cmake_template ${OpenCV_LIBS})
message(STATUS "OpenCV_LIBS: ${OpenCV_LIBS}")
add_custom_command(TARGET cmake_template POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:opencv_core> 
        $<TARGET_FILE:opencv_features2d>
        $<TARGET_FILE:opencv_flann>
        $<TARGET_FILE:opencv_imgcodecs>
        $<TARGET_FILE:opencv_imgproc>
        $<TARGET_FILE:opencv_plot>
        $<TARGET_FILE:opencv_tracking>
        $<TARGET_FILE:opencv_video>
        $<TARGET_FILE:opencv_videoio>
        $<TARGET_FILE:opencv_xfeatures2d>

        $<TARGET_FILE_DIR:cmake_template>)
