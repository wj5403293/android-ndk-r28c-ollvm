# android-ndk-r28c-ollvm

## 简介

中文 | [English](README.en.md)

---

> My English proficiency is insufficient, so this document will be translated using AI.

---

`android-ndk-r28c-ollvm` is an NDK compiled and packaged for the Android platform.
The compilers within this NDK integrate Obfuscation LLVM, which has many defects, but the core functionalities are operational and usable.

## PREFACE

This NDK is designed for the Android platform and is recommended for use in a Termux shell environment.
You can install Termux within [Termux](https://termux.com/).
After installation, run `pkg update` to update the packages.
After that, run the command `pkg install git` to install the Git package.

## INSTALLATION

1. Clone this repository.

    ```bash
    git clone --depth=1 https://github.com/fullerror11/android-ndk-r28c-ollvm.git
    ```

2. Run the installation script.

    ```bash
    chmod +x scripts/install.sh /path/to/install-dir
    ./scripts/install.sh
    ```

    Alternatively, enter the installation path interactively when the script runs.

    ```bash
    chmod +x scripts/install.sh
    ./scripts/install.sh
    ```

3. Configure the environment variables.

    For different shell environments, you can refer to the following commands:

    - bash/zsh

        Add the following content to `~/.bashrc` or `~/.zshrc`:

        ```bash
        export ANDROID_NDK_ROOT=/path/to/install-dir/android-ndk-r28c-ollvm
        ```

    - fish

        Add the following content to `~/.config/fish/config.fish`:

        ```fish
        set -gx ANDROID_NDK_ROOT /path/to/install-dir/android-ndk-r28c-ollvm
        ```

## Parameters

For details, see [...#L26-L57](https://github.com/DreamSoule/ollvm17/blob/main/README.md#L26-L57).

## USAGE

This document only provides usage examples for compiling ELF executables.

- Compile using clang/clang++.

    The source code for this demo is located in the `demo/clang-clang++` directory.

    ```bash
    cd demo/clang-clang++
    ```

    1. Set the compiler programs within the NDK to the PATH environment variable and then invoke them.

        Set the PATH environment variable.

        ```bash
        export PATH=$PATH:${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-arm64/bin
        ```

        Or fish。

        ```fish
        set -gx PATH ${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-arm64/bin $PATH
        ```

        Compile the program.

        ```bash
        clang++ main.cpp -o main
        ```

    2. Directly invoke it using the ANDROID_NDK_ROOT environment variable.

        ```bash
        ${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-arm64/bin/clang++ main.cpp -o main
        ```

    Execute the program.

    ```bash
    chmod +x main
    ./main
    ```

- Compiling with ndk-build  

  The source code for this demo is located in the `demo/ndk-build` directory.  

  ```bash
  cd demo/ndk-build
  ```

  1. Set the NDK to the PATH environment variable and then invoke it  

      Set the PATH environment variable.  

      ```bash
      export PATH=$PATH:${ANDROID_NDK_ROOT}
      ```

      Or for fish:  

      ```fish
      set -gx PATH ${ANDROID_NDK_ROOT} $PATH
      ```

      Compile the program.  

      ```bash
      ndk-build
      ```

  2. Directly invoke it using the ANDROID_NDK_ROOT environment variable  

      ```bash
      ${ANDROID_NDK_ROOT}/ndk-build
      ```

  Execute the program.  

  ```bash
  chmod +x libs/arm64-v8a/demo-ndk-build
  ./libs/arm64-v8a/demo-ndk-build
  ```

- Compiling with cmake  

  > **Note**: This example requires the `cmake` and `make` packages to be available in the shell environment.  
  > To install the packages, execute the following commands:  
  >
  > In Termux:  
  >
  > ```bash
  > pkg install cmake make
  > ```

  The source code for this demo is located in the `demo/cmake` directory.  

  ```bash
  cd demo/cmake
  ```

  Generate the cache files.  

  ```bash
  cmake -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
      -DANDROID_NDK=${ANDROID_NDK_ROOT} \
      -DANDROID_ABI=arm64-v8a \
      -DANDROID_PLATFORM=android-24 \
      -B build
  ```

  Compile the program.  

  ```bash
  cmake --build build
  ```

  Execute the program.  

  ```bash
  chmod +x build/demo-cmake
  ./build/demo-cmake
  ```

## References  

[llvm-project](https://github.com/llvm/llvm-project)  

[ollvm-19](https://github.com/Haedus-Industries/ollvm-19)  

[android-ndk-custom](https://github.com/HomuHomu833/android-ndk-custom)  

> Also, thanks to all the open-source projects referenced by the projects mentioned above.
