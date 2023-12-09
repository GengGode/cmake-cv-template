###
# 配置并下载opencv进行编译
###

set(ENV{http_proxy} "http://127.0.0.1:1080")
set(ENV{https_proxy} "http://127.0.0.1:1080")

function(auto_download_opencv_contrib opencv_contrib_path module_path)
    set(cache_path ${CMAKE_CURRENT_BINARY_DIR}/.cache)
    if (EXISTS ${cache_path}/opencv_contrib.zip)
        message(STATUS "opencv_contrib.zip exists, skip download")
    else()
        message(STATUS "opencv_contrib.zip not exists, download it")
        message(STATUS "opencv_contrib_path not exists, download it")
        # https://github.com/opencv/opencv_contrib/archive/refs/tags/4.8.0.zip v4.8.0
        set(opencv_contrib_url "https://github.com/opencv/opencv_contrib/archive/refs/tags/4.8.0.zip")
        file(DOWNLOAD ${opencv_contrib_url} ${cache_path}/opencv_contrib.zip SHOW_PROGRESS LOG ${cache_path}/opencv_contrib.log)
    endif()
    if (EXISTS ${cache_path}/opencv_contrib-4.8.0/modules)
        message(STATUS "opencv_contrib_path exists, skip unzip")
    else()
        message(STATUS "opencv_contrib_path not exists, unzip it")
        execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${cache_path}/opencv_contrib.zip WORKING_DIRECTORY ${cache_path})
    endif()
    if(NOT EXISTS ${cache_path}/opencv_contrib-4.8.0/modules)
        message(FATAL_ERROR "opencv_contrib install faild")
    endif()
    set(${opencv_contrib_path} ${cache_path}/opencv_contrib-4.8.0 PARENT_SCOPE)
    set(${module_path} ${cache_path}/opencv_contrib-4.8.0/modules PARENT_SCOPE)
endfunction(auto_download_opencv_contrib)

function(auto_download_opencv opencv_path)
    set(cache_path ${CMAKE_CURRENT_BINARY_DIR}/.cache)
    if (EXISTS ${cache_path}/opencv.zip)
        message(STATUS "opencv.zip exists, skip download")
    else()
        message(STATUS "opencv.zip not exists, download it")
        # https://github.com/opencv/opencv/archive/refs/tags/4.8.0.zip v4.8.0
        set(opencv_url "https://github.com/opencv/opencv/archive/refs/tags/4.8.0.zip")
        file(DOWNLOAD ${opencv_url} ${cache_path}/opencv.zip SHOW_PROGRESS LOG ${cache_path}/opencv.log)
    endif()
    if (EXISTS ${cache_path}/opencv-4.8.0/modules)
        message(STATUS "opencv_path exists, skip unzip")
    else()
        message(STATUS "opencv_path not exists, unzip it")
        execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${cache_path}/opencv.zip WORKING_DIRECTORY ${cache_path})
    endif()
    if(NOT EXISTS ${cache_path}/opencv-4.8.0/modules)
        message(FATAL_ERROR "opencv install faild")
    endif()
    set(${opencv_path} ${cache_path}/opencv-4.8.0 PARENT_SCOPE)
endfunction(auto_download_opencv)

function(build_opencv_and_contrib opencv_path opencv_contrib_modules_path)
    if(NOT EXISTS ${opencv_path})
        message(FATAL_ERROR "opencv_path not exists :${opencv_path}")
    endif()   
    if(NOT EXISTS ${opencv_contrib_modules_path})
        message(FATAL_ERROR "opencv_contrib_modules_path not exists :${opencv_contrib_modules_path}")
    endif()
    #if(EXISTS ${opencv_path}/build/install)
    #    message(STATUS "opencv already builded")
    #    return()
    #endif()

    set(BUILD_IPP_IW ON)
    set(BUILD_ITT ON)
    set(BUILD_JAVA OFF)
    set(BUILD_PERF_TESTS OFF)
    set(BUILD_SHARED_LIBS ON)
    set(BUILD_TBB OFF)
    set(BUILD_TESTS OFF)
    set(BUILD_PYTHON OFF)
    set(BUILD_EXAMPLES OFF)

    set(BUILD_opencv_apps OFF)
    set(BUILD_opencv_aruco OFF)
    set(BUILD_opencv_bgsegm OFF)
    set(BUILD_opencv_bioinspired OFF)
    set(BUILD_opencv_calib3d ON)
    set(BUILD_opencv ccalib OFF)
    set(BUILD_opencv_core ON)
    set(BUILD_opencv_datasets OFF)
    set(BUILD_opencv_dnn OFF)
    set(BUILD_opencv_dnn_objdetect OFF)
    set(BUILD_opencv_dnn_superres OFF)
    set(BUILD_opencv_dpm OFF)
    set(BUILD_opencv_face OFF)
    set(BUILD_opencv_features2d ON)
    set(BUILD_opencv_flann ON)
    set(BUILD_opencv_fuzzy OFF)
    set(BUILD_opencv_gapi OFF)
    set(BUILD_opencv_hfs OFF)
    set(BUILD_opencv_highgui OFF)
    set(BUILD_opencv_img_hash OFF)
    set(BUILD_opencv_imgcodecs ON)
    set(BUILD_opencv_imgproc ON)
    set(BUILD_opencv_intensity_transform OFF)
    set(BUILD_opencv java_bindings_generator OFF)
    set(BUILD_opencv_js OFF)
    set(BUILD_opencv js_bindings_generator OFF)
    set(BUILD_opencv_line_descriptor OFF)
    set(BUILD_opencv_mcc OFF)
    set(BUILD_opencv_ml  OFF)
    set(BUILD_opencv_objc_bindings_generator OFF)
    set(BUILD_opencv_objdetect OFF)
    set(BUILD_opencv_optflow OFF)
    set(BUILD_opencv_phase_unwrapping OFF)
    set(BUILD_opencv_photo OFF)
    set(BUILD_opencv_plot ON)
    set(BUILD_opencv_python_bindings_generator OFF)
    set(BUILD_opencv_python_tests OFF)
    set(BUILD_opencv_quality OFF)
    set(BUILD_opencv_rapid OFF)
    set(BUILD_opencv_reg OFF)
    set(BUILD_opencv_rgbd OFF)
    set(BUILD_opencv_saliency OFF)
    set(BUILD_opencv_shape OFF)
    set(BUILD_opencv_stereo OFF)
    set(BUILD_opencv_stitching OFF)
    set(BUILD_opencv_structured_light OFF)
    set(BUILD_opencv_superres OFF)
    set(BUILD_opencv_surface_matching OFF)
    set(BUILD_opencv_text OFF)
    set(BUILD_opencv_tracking ON)
    set(BUILD_opencv_ts OFF)
    set(BUILD_opencv_video ON)
    set(BUILD_opencv_videoio ON)
    set(BUILD_opencv_videostab OFF)
    set(BUILD_opencv_wechat_qrcode OFF)
    set(BUILD_opencv_world OFF)
    set(BUILD_opencv_xfeatures2d ON)
    set(BUILD_opencv_ximgproc OFF)
    set(BUILD_opencv_xobjdetect OFF)
    set(BUILD_opencv_xphoto OFF)

    set(OPENCV_ENABLE_NOFREE ON)
    set(OPENCV_EXTRA_MODULES_PATH ${opencv_contrib_modules_path})

    set(CMAKE_INSTALL_PREFIX ${opencv_path}/build/install)
    set(OpenCV_DIR ${opencv_path}/build/install)

    # 编译opencv
    message(STATUS "build opencv")
    message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
    include(ExternalProject)
    ExternalProject_Add(opencv
        PREFIX ${opencv_path}/build
        SOURCE_DIR ${opencv_path}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DBUILD_IPP_IW=${BUILD_IPP_IW}
            -DBUILD_ITT=${BUILD_ITT}
            -DBUILD_JAVA=${BUILD_JAVA}
            -DBUILD_PERF_TESTS=${BUILD_PERF_TESTS}
            -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
            -DBUILD_TBB=${BUILD_TBB}
            -DBUILD_TESTS=${BUILD_TESTS}
            -DBUILD_PYTHON=${BUILD_PYTHON}
            -DBUILD_EXAMPLES=${BUILD_EXAMPLES}
            -DBUILD_opencv_apps=${BUILD_opencv_apps}
            -DBUILD_opencv_aruco=${BUILD_opencv_aruco}
            -DBUILD_opencv_bgsegm=${BUILD_opencv_bgsegm}
            -DBUILD_opencv_bioinspired=${BUILD_opencv_bioinspired}
            -DBUILD_opencv_calib3d=${BUILD_opencv_calib3d}
            -DBUILD_opencv_ccalib=${BUILD_opencv_ccalib}
            -DBUILD_opencv_core=${BUILD_opencv_core}
            -DBUILD_opencv_datasets=${BUILD_opencv_datasets}
            -DBUILD_opencv_dnn=${BUILD_opencv_dnn}
            -DBUILD_opencv_dnn_objdetect=${BUILD_opencv_dnn_objdetect}
            -DBUILD_opencv_dnn_superres=${BUILD_opencv_dnn_superres}
            -DBUILD_opencv_dpm=${BUILD_opencv_dpm}
            -DBUILD_opencv_face=${BUILD_opencv_face}
            -DBUILD_opencv_features2d=${BUILD_opencv_features2d}
            -DBUILD_opencv_flann=${BUILD_opencv_flann}
            -DBUILD_opencv_fuzzy=${BUILD_opencv_fuzzy}
            -DBUILD_opencv_gapi=${BUILD_opencv_gapi}
            -DBUILD_opencv_hfs=${BUILD_opencv_hfs}
            -DBUILD_opencv_highgui=${BUILD_opencv_highgui}
            -DBUILD_opencv_img_hash=${BUILD_opencv_img_hash}
            -DBUILD_opencv_imgcodecs=${BUILD_opencv_imgcodecs}
            -DBUILD_opencv_imgproc=${BUILD_opencv_imgproc}
            -DBUILD_opencv_intensity_transform=${BUILD_opencv_intensity_transform}
            -DBUILD_opencv_java_bindings_generator=${BUILD_opencv_java_bindings_generator}
            -DBUILD_opencv_js=${BUILD_opencv_js}
            -DBUILD_opencv_js_bindings_generator=${BUILD_opencv_js_bindings_generator}
            -DBUILD_opencv_line_descriptor=${BUILD_opencv_line_descriptor}
            -DBUILD_opencv_mcc=${BUILD_opencv_mcc}
            -DBUILD_opencv_ml=${BUILD_opencv_ml}
            -DBUILD_opencv_objc_bindings_generator=${BUILD_opencv_objc_bindings_generator}
            -DBUILD_opencv_objdetect=${BUILD_opencv_objdetect}
            -DBUILD_opencv_optflow=${BUILD_opencv_optflow}
            -DBUILD_opencv_phase_unwrapping=${BUILD_opencv_phase_unwrapping}
            -DBUILD_opencv_photo=${BUILD_opencv_photo}
            -DBUILD_opencv_plot=${BUILD_opencv_plot}
            -DBUILD_opencv_python_bindings_generator=${BUILD_opencv_python_bindings_generator}
            -DBUILD_opencv_python_tests=${BUILD_opencv_python_tests}
            -DBUILD_opencv_quality=${BUILD_opencv_quality}
            -DBUILD_opencv_rapid=${BUILD_opencv_rapid}
            -DBUILD_opencv_reg=${BUILD_opencv_reg}
            -DBUILD_opencv_rgbd=${BUILD_opencv_rgbd}
            -DBUILD_opencv_saliency=${BUILD_opencv_saliency}
            -DBUILD_opencv_shape=${BUILD_opencv_shape}
            -DBUILD_opencv_stereo=${BUILD_opencv_stereo}
            -DBUILD_opencv_stitching=${BUILD_opencv_stitching}
            -DBUILD_opencv_structured_light=${BUILD_opencv_structured_light}
            -DBUILD_opencv_superres=${BUILD_opencv_superres}
            -DBUILD_opencv_surface_matching=${BUILD_opencv_surface_matching}
            -DBUILD_opencv_text=${BUILD_opencv_text}
            -DBUILD_opencv_tracking=${BUILD_opencv_tracking}
            -DBUILD_opencv_ts=${BUILD_opencv_ts}
            -DBUILD_opencv_video=${BUILD_opencv_video}
            -DBUILD_opencv_videoio=${BUILD_opencv_videoio}
            -DBUILD_opencv_videostab=${BUILD_opencv_videostab}
            -DBUILD_opencv_wechat_qrcode=${BUILD_opencv_wechat_qrcode}
            -DBUILD_opencv_world=${BUILD_opencv_world}
            -DBUILD_opencv_xfeatures2d=${BUILD_opencv_xfeatures2d}
            -DBUILD_opencv_ximgproc=${BUILD_opencv_ximgproc}
            -DBUILD_opencv_xobjdetect=${BUILD_opencv_xobjdetect}
            -DBUILD_opencv_xphoto=${BUILD_opencv_xphoto}
            -DOPENCV_ENABLE_NONFREE=${OPENCV_ENABLE_NONFREE}
            -DOPENCV_EXTRA_MODULES_PATH=${OPENCV_EXTRA_MODULES_PATH}
        BUILD_ALWAYS 1
        INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    )

    if (NOT EXISTS ${CMAKE_INSTALL_PREFIX}/lib)
        message(STATUS "opencv build faild")
        endif()
    message(STATUS "build opencv done")
endfunction(build_opencv_and_contrib)

macro(auto_find_opencv is_static)
    auto_download_opencv_contrib(opencv_contrib_path module_path)
    message(STATUS "opencv_contrib_path: ${opencv_contrib_path}")
    message(STATUS "module_path: ${module_path}")
    auto_download_opencv(opencv_path)
    message(STATUS "opencv_path: ${opencv_path}")
    build_opencv_and_contrib(${opencv_path} ${module_path})
    set(OpenCV_DIR ${opencv_path}/build/install)
    find_package(OpenCV REQUIRED)
endmacro(auto_find_opencv )
