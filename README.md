# android-ndk-r28c-ollvm

## 简介

中文 | [English](README.en.md)

---

`android-ndk-r28c-ollvm` 是一个为 Android 平台编译并打包的 NDK。
NDK 内的编译器集成了 Obfuscation LLVM，存在很多缺陷，但基本功能正常可用。

> 其实很早之前就编译并打包了，但是当时懒得整理。

## 前言

本 NDK 用于安卓平台，推荐使用 Termux shell 环境。
可以在 [Termux](https://termux.com/) 中安装 Termux。
安装后，运行 `pkg update` 更新软件包。
随后，运行 `pkg install git` 命令安装 git 软件包。

## 安装

1. 克隆本仓库

    ```bash
    git clone --depth=1 https://github.com/fullerror11/android-ndk-r28c-ollvm.git
    ```

2. 执行安装脚本

    ```bash
    chmod +x scripts/install.sh /path/to/install-dir
    ./scripts/install.sh
    ```

    或在脚本运行时通过交互方式输入安装路径。

    ```bash
    chmod +x scripts/install.sh
    ./scripts/install.sh
    ```

3. 配置环境变量

    对于不同的 shell 环境，可以参考以下命令：

    - bash/zsh

        在 `~/.bashrc` 或 `~/.zshrc` 中添加以下内容：

        ```bash
        export ANDROID_NDK_ROOT=/path/to/install-dir/android-ndk-r28c-ollvm
        ```

    - fish

        在 `~/.config/fish/config.fish` 中添加以下内容：

        ```fish
        set -gx ANDROID_NDK_ROOT /path/to/install-dir/android-ndk-r28c-ollvm
        ```

## 参数

详见 [...#L26-L57](https://github.com/DreamSoule/ollvm17/blob/main/README.md#L26-L57)

## 使用

本文档仅提供编译 elf 可执行程序的使用例子。

- 使用 clang/clang++ 编译

    本 demo 使用源码在 demo/clang-clang++ 目录下。

    ```bash
    cd demo/clang-clang++
    ```

    1. 设置 NDK 内的编译器程序到 PATH 环境变量中后调用

        设置 PATH 环境变量。

        ```bash
        export PATH=$PATH:${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-arm64/bin
        ```

        或 fish。

        ```fish
        set -gx PATH ${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-arm64/bin $PATH
        ```

        编译程序。

        ```bash
        clang++ main.cpp -o main
        ```

    2. 直接通过 ANDROID_NDK_ROOT 环境变量调用

        ```bash
        ${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-arm64/bin/clang++ main.cpp -o main
        ```

    执行程序。

    ```bash
    chmod +x main
    ./main
    ```

- 使用 ndk-build 编译

    本 demo 使用源码在 demo/ndk-build 目录下。

    ```bash
    cd demo/ndk-build
    ```

    1. 设置 NDK 到 PATH 环境变量中后调用

        设置 PATH 环境变量。

        ```bash
        export PATH=$PATH:${ANDROID_NDK_ROOT}
        ```

        或 fish。

        ```fish
        set -gx PATH ${ANDROID_NDK_ROOT} $PATH
        ```

        编译程序。

        ```bash
        ndk-build
        ```

    2. 直接通过 ANDROID_NDK_ROOT 环境变量调用

        ```bash
        ${ANDROID_NDK_ROOT}/ndk-build
        ```

    执行程序。

    ```bash
    chmod +x libs/arm64-v8a/demo-ndk-build
    ./libs/arm64-v8a/demo-ndk-build
    ```

- 使用 cmake 编译

    > **注意**：本示例需要 shell 环境中存在 cmake 和 make 软件包。
    > 执行以下命令安装软件包：
    >
    > 在 Termux 中：
    >
    > ```bash
    > pkg install cmake make
    > ```

    本 demo 使用源码在 demo/cmake 目录下。

    ```bash
    cd demo/cmake
    ```

    生成缓存文件。

    ```bash
    cmake -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
        -DANDROID_NDK=${ANDROID_NDK_ROOT} \
        -DANDROID_ABI=arm64-v8a \
        -DANDROID_PLATFORM=android-24 \
        -B build
    ```

    编译程序。

    ```bash
    cmake --build build
    ```

    执行程序。

    ```bash
    chmod +x build/demo-cmake
    ./build/demo-cmake
    ```

## 参考

[llvm-project](https://github.com/llvm/llvm-project)

[ollvm-19](https://github.com/Haedus-Industries/ollvm-19)

[android-ndk-custom](https://github.com/HomuHomu833/android-ndk-custom)

> 同时感谢所有被参考项目所参考的开源项目。
