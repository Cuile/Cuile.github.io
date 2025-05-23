---
title: "Nuitka 参数列表"
date: 2025-03-16T11:07:37+08:00
# draft: true

tags:
- nuitka
- python
---
Usage: python.exe -m nuitka [--mode=compilation_mode] [--run] [options] main_module.py

    Note: For general plugin help (they often have their own command line options too), consider the output of '--help-plugins'.


|                        | Options:                        | 选项：   |
|---                     |---                              |---|
|--help                  | show this help message and exit 
|--version               | Show version information and important details for bug reports, then exit. Defaults to off.
|--module                | Create an importable binary extension module executable instead of a program. Defaults to off. | 创建可导入的二进制扩展模块可执行文件，而不是程序。默认为关闭。
|--mode=COMPILATION_MODE | Mode in which to compile. Accelerated runs in your Python installation and epends on it. Standalone creates a folder with an executable contained to run it. Onefile creates a single executable to deploy. App is onefile except on macOS where it's not to be used. Module makes a module, and package includes also all sub-modules and sub-packages. Default is 'accelerated'. | 编译模式。Accelerated 在 Python 安装中运行并依附于它。Standalone 会创建一个包含可执行文件的文件夹，以便运行。Onefile 创建单个可执行文件以进行部署。App 就是 onefile，在 macOS 上不使用。Module 制作一个模块，软件包也包括所有子模块和子软件包。默认为 “accelerated”。
|--standalone            | Enable standalone mode for output. This allows you to transfer the created binary to other machines without it using an existing Python installation. This also means it will become big. It implies these option: "--follow-imports" and "--python-flag=no_site". Defaults to off. | 启用独立输出模式。这样就可以将创建的二进制文件传输到其他机器上，而无需使用现有的 Python 安装。这也意味着它将变得很大。这意味着需要这些选项： “follow-imports“ 和 ”--python-flag=no_site"。默认为关闭。
|--onefile               | On top of standalone mode, enable onefile mode. This means not a folder, but a compressed executable is created and used. Defaults to off. | 在独立模式的基础上，启用单文件模式。这意味着创建和使用的不是文件夹，而是压缩后的可执行文件。默认为关闭。
|--python-flag=FLAG      | Python flags to use. Default is what you are using to run Nuitka, this enforces a specific mode. These are options that also exist to standard Python executable. Currently supported: "-S" (alias "no_site"), "static_hashes" (do not use hash randomization), "no_warnings" (do not give Python run time warnings), "-O" (alias "no_asserts"), "no_docstrings" (do not use doc strings), "-u" (alias "unbuffered"), "isolated" (do not load outside code) and "-m" (package mode, compile as "package.__main__"). Default empty. | 要使用的 Python 标志。默认值是运行 Nuitka 时使用的值，它强制执行特定的模式。这些选项也存在于标准 Python 可执行文件中。目前支持 “-S“（别名 ”no_site“）、”static_hashes“（不使用哈希随机化）、”no_warnings“（不给出 Python 运行时警告）、”-O“（别名 ”no_asserts“）、”no_docstrings“（不使用文档字符串）、”-u“（别名 ”unbuffered“）、”isol isolated“（不加载外部代码）和”-m“（包模式，编译为 ”package.__main__"）。默认为空。
|--python-debug          | Use debug version or not. Default uses what you are using to run Nuitka, most likely a non-debug version. Only for debugging and testing purposes. | 是否使用调试版本。默认使用运行 Nuitka 的版本，很可能是非调试版本。仅用于调试和测试目的。
|--python-for-scons=PATH | When compiling with Python 3.4 provide the path of a Python binary to use for Scons. Otherwise Nuitka can use what you run Nuitka with, or find Python installation, e.g. from Windows registry. On Windows, a Python 3.5 or higher is needed. On non-Windows, a Python 2.6 or 2.7 will do as well. | 使用 Python 3.4 编译时，请提供 Scons 使用的 Python 二进制文件的路径。否则，Nuitka 可以使用您运行 Nuitka 时所使用的路径，或者从 Windows 注册表中查找 Python 的安装路径。在 Windows 上，需要 Python 3.5 或更高版本。在非 Windows 下，Python 2.6 或 2.7 也可以。
|--main=PATH             | If specified once, this takes the place of the positional argument, i.e. the filename to compile. When given multiple times, it enables "multidist" (see User Manual) it allows you to create binaries that depending on file name or invocation name. | 如果只指定一次，它将取代位置参数，即要编译的文件名。如果多次指定，则会启用 “multidist”（参见《用户手册》），允许根据文件名或调用名创建二进制文件。
  
|                               | Backend C compiler choice: | 后端 C 编译器选择： |
|---                            |---                         |---                 |
|--clang                        | Enforce the use of clang. On Windows this requires a working Visual Studio version to piggy back on. Defaults to off. | 强制使用 clang。在 Windows 环境下，这需要一个正常运行的 Visual Studio 版本作为辅助。默认为关闭。
|--mingw64                      | Enforce the use of MinGW64 on Windows. Defaults to off unless MSYS2 with MinGW Python is used. | 强制在 Windows 上使用 MinGW64。默认为关闭，除非使用带有 MinGW Python 的 MSYS2。
|--msvc=MSVC_VERSION            | Enforce the use of specific MSVC version on Windows. Allowed values are e.g. "14.3" (MSVC 2022) and other MSVC version numbers, specify "list" for a list of installed compilers, or use "latest".  Defaults to latest MSVC being used if installed, otherwise MinGW64 is used. | 强制在 Windows 上使用特定的 MSVC 版本。允许的值包括 “14.3”（MSVC 2022）和其他 MSVC 版本号，指定 “list ”表示已安装的编译器列表，或使用 “latest”。 如果已安装，默认使用最新的 MSVC，否则使用 MinGW64。
|--jobs=N                       | Specify the allowed number of parallel C compiler jobs. Negative values are system CPU minus the given value. Defaults to the full system CPU count unless low memory mode is activated, then it defaults to 1. | 指定允许的 C 编译器并行作业数。负值为系统 CPU 减去给定值。默认为整个系统 CPU 数量，除非激活了低内存模式，否则默认为 1。
|--lto=choice                   | Use link time optimizations (MSVC, gcc, clang). Allowed values are "yes", "no", and "auto" (when it's known to work). Defaults to "auto". | 使用链接时间优化（MSVC、gcc、clang）。允许的值有 “是”、“否 ”和 “自动”（已知有效时）。默认为 “自动”。
|--static-libpython=choice      | Use static link library of Python. Allowed values are "yes", "no", and "auto" (when it's known to work). Defaults to "auto". | 使用 Python 的静态链接库。允许的值有 “yes”、“no ”和 “auto”（已知有效时）。默认为 “auto”。
|--cf-protection=PROTECTION_MODE| This option is gcc specific. For the gcc compiler, select the "cf-protection" mode. Default "auto" is to use the gcc default value, but you can override it, e.g. to disable it with "none" value. Refer to gcc documentation for "-fcf-protection" for the details. | 该选项针对 gcc。对于 gcc 编译器，请选择 “cf-protection ”模式。默认值为 “auto”，即使用 gcc 的默认值，但也可以覆盖它，例如使用 “none ”值禁用它。详情请参阅 gcc 文档中的“-fcf-protection”。

|                                           | Onefile options: | Onefile 选项： |
|---                                        |---               |---            |
|--onefile-tempdir-spec=ONEFILE_TEMPDIR_SPEC| Use this as a folder to unpack to in onefile mode. Defaults to '{TEMP}/onefile_{PID}_{TIME}', i.e. user temporary directory and being non-static it's removed. Use e.g. a string like '{CACHE_DIR}/{COMPANY}/{PRODUCT}/{VERSION}' which is a good static cache path, this will then not be removed.|在单文件模式下，将其作为解压到的文件夹。默认为“{TEMP}/onefile_{PID}_{TIME}”，即用户临时目录，非静态时会被移除。例如，使用类似“{CACHE_DIR}/{COMPANY}/{PRODUCT}/{VERSION}”的字符串，这是一个很好的静态缓存路径，因此不会被移除。
--onefile-child-grace-time=GRACE_TIME_MS    | When stopping the child, e.g. due to CTRL-C or shutdown, etc. the Python code gets a "KeyboardInterrupt", that it may handle e.g. to flush data. This is the amount of time in ms, before the child it killed in the hard way. Unit is ms, and default 5000. | 当停止子进程时，例如，由于 CTRL-C 或关机等原因，Python 代码会收到一个 “KeyboardInterrupt”（键盘中断），它可以处理这个中断，例如，刷新数据。这是以毫秒为单位的时间量，在子进程被强制杀死之前。单位为 ms，默认为 5000。
--onefile-no-compression                    | When creating the onefile, disable compression of the payload. This is mostly for debug purposes, or to save time. Default is off. | 创建 onefile 时，禁用对有效载荷的压缩。这主要是为了调试或节省时间。默认为关闭。
--onefile-as-archive                        | When creating the onefile, use an archive format, that can be unpacked with nuitka-onefile-unpack" rather than a stream that only the onefile program itself unpacks. Default is off. | 创建 onefile 时，使用可以用 nuitka-onefile-unpack 解压的压缩包格式，而不是只能由 onefile 程序自己解压的流格式。默认为关闭。

|                                       | Data files: | 数据文件： |
|---                                    |---          |---        |
|--include-package-data=PACKAGE         | Include data files for the given package name. DLLs and extension modules are not data files and never included like this. Can use patterns the filenames as indicated below. Data files of packages are not included by default, but package configuration can do it. This will only include non-DLL, non-extension modules, i.e. actual data files. After a ":" optionally a filename pattern can be given as well, selecting only matching files. Examples: "--include-package-data=package_name" (all files) "--include-package-data=package_name:*.txt" (only certain type) "--include-package-data=package_name:some_filename.dat" (concrete file) Default empty. | 包括指定软件包名称的数据文件。动态链接库和扩展模块不是数据文件，因此不会像这样被包含。可以使用如下所示的文件名模式。默认情况下不包含软件包的数据文件，但软件包配置可以这样做。这只会包含非 DLL、非扩展模块，即实际的数据文件。在“: ”后还可选择给出文件名模式，只选择匹配的文件。例如 “--include-package-data=package_name“（所有文件） ”--include-package-data=package_name:*.txt“（仅特定类型） ”--include-package-data=package_name:some_filename.dat"（具体文件） 默认为空。
|--include-data-files=DESC              | Include data files by filenames in the distribution. There are many allowed forms. With '--include-data-files=/path/to/file/*.txt=folder_name/some.txt' it will copy a single file and complain if it's multiple. With '--include-data-files=/path/to/files/*.txt=folder_name/' it will put all matching files into that folder. For recursive copy there is a form with 3 values that '--include-data-files=/path/to/scan=folder_name/=**/*.txt' that will preserve directory structure. Default empty. | 按文件名将数据文件包含在分发文件中。允许的形式有很多种。如果使用“--include-data-files=/path/to/file/*.txt=folder_name/some.txt”，它将复制单个文件，如果是多个文件则会抱怨。如果使用“--include-data-files=/path/to/files/*.txt=folder_name/”，则会将所有匹配文件放入该文件夹。对于递归复制，“--include-data-files=/path/to/scan=folder_name/=**/*.txt ”表格包含 3 个值，将保留目录结构。默认为空。
|--include-data-dir=DIRECTORY           | Include data files from complete directory in the distribution. This is recursive. Check '--include-data-files' with patterns if you want non-recursive inclusion. An example would be '--include-data-dir=/path/some_dir=data/some_dir' for plain copy, of the whole directory. All non-code files are copied, if you want to use '--noinclude-data-files' option to remove them. Default empty. | 包含发行版中完整目录下的数据文件。这是递归的。如果想要非递归包含，请勾选带有模式的“--include-data-files”。例如，“--include-data-dir=/path/some_dir=data/some_dir ”是对整个目录的纯复制。如果想使用“--noinclude-data-files ”选项删除非代码文件，则会复制所有非代码文件。默认为空。
|--noinclude-data-files=PATTERN         | Do not include data files matching the filename pattern given. This is against the target filename, not source paths. So to ignore a file pattern from package data for 'package_name' should be matched as 'package_name/*.txt'. Or for the whole directory simply use 'package_name'. Default empty. | 不包含与给定文件名模式匹配的数据文件。这针对的是目标文件名，而不是源路径。因此，要忽略 “package_name ”的软件包数据中的文件模式，应匹配为 “package_name/*.txt”。或者，对于整个目录，只需使用 “package_name ”即可。默认为空。
|--include-onefile-external-data=PATTERN| Include the specified data file patterns outside of the onefile binary, rather than on the inside. Makes only sense in case of '--onefile' compilation. First files have to be specified as included with other `--include-*data*` options, and then this refers to target paths inside the distribution. Default empty. | 将指定的数据文件模式包含在 onefile 二进制文件的外部，而不是内部。只有在“--onefile ”编译时才有意义。首先，必须使用其他 `--include-*data*`选项指定包含的文件，然后才会引用发行版内部的目标路径。默认为空。
|--list-package-data=LIST_PACKAGE_DATA  | Output the data files found for a given package name.Default not done. | 输出为给定软件包名称找到的数据文件，默认为未完成。
|--include-raw-dir=DIRECTORY            | Include raw directories completely in the distribution. This is recursive. Check '--include-data-dir' to use the sane option. Default empty. | 将原始目录完全包含在发行版中。这是递归的。选中“--include-data-dir ”以使用正常选项。默认为空。

|                                                | Compilation choices: | 编译选择： |
|---                                             |---                   |---        |
|--user-package-configuration-file=YAML_FILENAME | User provided Yaml file with package configuration. You can include DLLs, remove bloat, add hidden dependencies. Check the Nuitka Package Configuration Manual for a complete description of the format to use. Can be given multiple times. Defaults to empty. | 用户提供的 Yaml 文件包含软件包配置。您可以包含 DLL、删除臃肿、添加隐藏的依赖关系。有关使用格式的完整说明，请查阅《Nuitka 软件包配置手册》。可多次给出。默认为空。
|--full-compat                                   | Enforce absolute compatibility with CPython. Do not even allow minor deviations from CPython behavior, e.g. not having better tracebacks or exception messages which are not really incompatible, but only different or worse. This is intended for tests only and should *not* be used. | 确保与 CPython 绝对兼容。甚至不允许与 CPython 行为有细微的偏差，例如，不允许有更好的跟踪回溯或异常消息，这些并不是真正的不兼容，而只是不同或更糟而已。这仅用于测试，*不*应使用。
|--file-reference-choice=FILE_MODE               | Select what value "__file__" is going to be. With "runtime" (default for standalone binary mode and module mode), the created binaries and modules, use the location of themselves to deduct the value of "__file__". Included packages pretend to be in directories below that location. This allows you to include data files in deployments. If you merely seek acceleration, it's better for you to use the "original" value, where the source files location will be used. With "frozen" a notation "<frozen module_name>" is used. For compatibility reasons, the "__file__" value will always have ".py" suffix independent of what it really is. | 选择“__file__”的值。如果使用 “runtime”（独立二进制文件模式和模块模式的默认值），创建的二进制文件和模块将使用自己的位置来扣除“__file__”的值。包含的软件包会假装位于该位置下方的目录中。这样就可以在部署中包含数据文件。如果只是为了加速，最好使用"original"值，即使用源文件的位置。在使用 “frozen ”时，会使用“<frozen module_name>”符号。出于兼容性考虑，“__file__”值的后缀始终是“.py”，与实际内容无关。
|--module-name-choice=MODULE_NAME_MODE           | Select what value "__name__" and "__package__" are going to be. With "runtime" (default for module mode), the created module uses the parent package to deduce the value of "__package__", to be fully compatible. The value "original" (default for other modes) allows for more static optimization to happen, but is incompatible for modules that normally can be loaded into any package. | 选择“__name__”和“__package__”的值。如果使用 “runtime”（模块模式的默认值），创建的模块会使用父软件包来推断“__package__”的值，以实现完全兼容。"original"值（其他模式的默认值）允许进行更多的静态优化，但对于通常可以加载到任何软件包的模块来说是不兼容的。

|                                      | General OS controls: | 一般操作系统控制： |
|---                                   |---                   |---                |
|--force-stdout-spec=FORCE_STDOUT_SPEC | Force standard output of the program to go to this location. Useful for programs with disabled console and programs using the Windows Services Plugin of Nuitka commercial. Defaults to not active, use e.g. '{PROGRAM_BASE}.out.txt', i.e. file near your program, check User Manual for full list of available values. | 强制程序的标准输出到此位置。对于禁用控制台的程序和使用 Nuitka 商业版 Windows 服务插件的程序非常有用。默认情况下不激活，例如使用“{PROGRAM_BASE}.out.txt”，即程序附近的文件，查看《用户手册》以获取可用值的完整列表。
|--force-stderr-spec=FORCE_STDERR_SPEC | Force standard error of the program to go to this location. Useful for programs with disabled console and programs using the Windows Services Plugin of Nuitka commercial. Defaults to not active, use e.g. '{PROGRAM_BASE}.err.txt', i.e. file near your program, check User Manual for full list of available values. | 强制程序的标准错误转到此位置。对于禁用控制台的程序和使用 Nuitka commercial 的 Windows 服务插件的程序非常有用。默认值为 “未激活”，例如使用“{PROGRAM_BASE}.err.txt”，即程序附近的文件，查看《用户手册》以获取可用值的完整列表。

|                                                   | Deployment control: | 发布控制： |
|---                                                |---                  |---        |
|--deployment                                       | Disable code aimed at making finding compatibility issues easier. This will e.g. prevent execution with "-c" argument, which is often used by code that attempts run a module, and causes a program to start itself over and over potentially. Disable once you deploy to end users, for finding typical issues, this is very helpful during development. Default off. | 禁用旨在更容易发现兼容性问题的代码。例如，这将阻止“-c ”参数的执行，“-c ”参数通常被试图运行模块的代码所使用，并可能导致程序一次又一次地自动启动。一旦部署给最终用户，则禁用该功能，以查找典型问题，这在开发过程中非常有用。默认关闭。
|--no-deployment-flag=FLAG                          | Keep deployment mode, but disable selectively parts of it. Errors from deployment mode will output these identifiers. Default empty. | 保留部署模式，但有选择地禁用部分功能。部署模式下的错误将输出这些标识符。默认为空。
  
|                                                   | Environment control: | 环境控制： |
|---                                                |---                   |---        |
|--force-runtime-environment-variable=VARIABLE_SPEC | Force an environment variables to a given value. Default empty. | 强制环境变量为给定值。默认为空。

|                                                          | Windows specific controls: | Windows 专用控制： |
|---                                                       |---                         |---                |
|--windows-console-mode=CONSOLE_MODE                       | Select console mode to use. Default mode is 'force' and creates a console window unless the program was started from one. With 'disable' it doesn't create or use a console at all. With 'attach' an existing console will be used for outputs. With 'hide' a newly spawned console will be hidden and an already existing console will behave like 'force'. Default is 'force'. | 选择要使用的控制台模式。默认模式为 “force”，会创建一个控制台窗口，除非程序是从控制台窗口启动的。如果使用 “disable”模式，则根本不会创建或使用控制台。使用 “attach”时，将使用现有的控制台进行输出。如果使用 “hide”，新生成的控制台将被隐藏，而已经存在的控制台的行为与 “force ”类似。默认为 “force”。
|--windows-icon-from-ico=ICON_PATH                         | Add executable icon. Can be given multiple times for different resolutions or files with multiple icons inside. In the later case, you may also suffix with #<n> where n is an integer index starting from 1, specifying a specific icon to be included, and all others to be ignored. | 添加可执行图标。对于不同分辨率或包含多个图标的文件，可以多次添加。在后一种情况下，还可以使用 #<n> 作为后缀，其中 n 是一个从 1 开始的整数索引，用于指定要包含的特定图标，而忽略其他所有图标。
|--windows-icon-from-exe=ICON_EXE_PATH                     | Copy executable icons from this existing executable (Windows only). | 从现有可执行文件中复制可执行文件图标（仅限 Windows）。
|--onefile-windows-splash-screen-image=SPLASH_SCREEN_IMAGE | When compiling for Windows and onefile, show this while loading the application. Defaults to off. | 为 Windows 和 onefile 编译时，在加载应用程序时显示此选项。默认为关闭。
|--windows-uac-admin                                       | Request Windows User Control, to grant admin rights on execution. (Windows only). Defaults to off. | 请求 Windows 用户控制，授予执行管理权限。（仅限 Windows）。默认为关闭。
|--windows-uac-uiaccess                                    | Request Windows User Control, to enforce running from a few folders only, remote desktop access. (Windows only). Defaults to off. | 请求 Windows 用户控制，以强制执行仅从少数文件夹运行的远程桌面访问。

|                                    | Control the following into imported modules: | 以下内容控制模块导入： |
|---                                 |---                                           |---                   |
|--follow-imports                    | Descend into all imported modules. Defaults to on in standalone mode, otherwise off. | 深入所有导入的模块。独立模式下默认开启，否则关闭。
|--follow-import-to=MODULE/PACKAGE   | Follow to that module if used, or if a package, to the whole package. Can be given multiple times. Default empty. | 如果使用模块，则指向该模块；如果使用软件包，则指向整个软件包。可多次给出。默认为空。
|--nofollow-import-to=MODULE/PACKAGE | Do not follow to that module name even if used, or if a package name, to the whole package in any case, overrides all other options. This can also contain patterns, e.g. "*.tests". Can be given multiple times. Default empty. | 即使使用了该模块名，也不要跟随；如果使用了软件包名，则无论如何都要跟随整个软件包，并优先于所有其他选项。也可以包含模式，如 “*.tests”。可多次输入。默认为空。
|--nofollow-imports                  | Do not descend into any imported modules at all, overrides all other inclusion options and not usable for standalone mode. Defaults to off. | 完全不深入任何导入模块，优先于所有其他包含选项，不能用于独立模式。默认为关闭。
|--follow-stdlib                     | Also descend into imported modules from standard library. This will increase the compilation time by a lot and is also not well tested at this time and sometimes won't work. Defaults to off. | 还可以从标准库中导入模块。这将大大增加编译时间，而且目前尚未经过充分测试，有时可能无法正常工作。默认为关闭。

  Control the inclusion of modules and packages in result:
    --include-package=PACKAGE
                        Include a whole package. Give as a Python namespace,
                        e.g. "some_package.sub_package" and Nuitka will then
                        find it and include it and all the modules found below
                        that disk location in the binary or extension module
                        it creates, and make it available for import by the
                        code. To avoid unwanted sub packages, e.g. tests you
                        can e.g. do this "--nofollow-import-to=*.tests".
                        Default empty.
    --include-module=MODULE
                        Include a single module. Give as a Python namespace,
                        e.g. "some_package.some_module" and Nuitka will then
                        find it and include it in the binary or extension
                        module it creates, and make it available for import by
                        the code. Default empty.
    --include-plugin-directory=MODULE/PACKAGE
                        Include also the code found in that directory,
                        considering as if they are each given as a main file.
                        Overrides all other inclusion options. You ought to
                        prefer other inclusion options, that go by names,
                        rather than filenames, those find things through being
                        in "sys.path". This option is for very special use
                        cases only. Can be given multiple times. Default
                        empty.
    --include-plugin-files=PATTERN
                        Include into files matching the PATTERN. Overrides all
                        other follow options. Can be given multiple times.
                        Default empty.
    --prefer-source-code
                        For already compiled extension modules, where there is
                        both a source file and an extension module, normally
                        the extension module is used, but it should be better
                        to compile the module from available source code for
                        best performance. If not desired, there is --no-
                        prefer-source-code to disable warnings about it.
                        Default off.
  
  Metadata support:
    --include-distribution-metadata=DISTRIBUTION
                        Include metadata information for the given
                        distribution name. Some packages check metadata for
                        presence, version, entry points, etc. and without this
                        option given, it only works when it's recognized at
                        compile time which is not always happening. This of
                        course only makes sense for packages that are included
                        in the compilation. Default empty.

  DLL files:
    --noinclude-dlls=PATTERN
                        Do not include DLL files matching the filename pattern
                        given. This is against the target filename, not source
                        paths. So ignore a DLL 'someDLL' contained in the
                        package 'package_name' it should be matched as
                        'package_name/someDLL.*'. Default empty.
    --list-package-dlls=LIST_PACKAGE_DLLS
                        Output the DLLs found for a given package name.
                        Default not done.
    --list-package-exe=LIST_PACKAGE_EXE
                        Output the EXEs found for a given package name.
                        Default not done.

  Control the warnings to be given by Nuitka:
    --warn-implicit-exceptions
                        Enable warnings for implicit exceptions detected at
                        compile time.
    --warn-unusual-code
                        Enable warnings for unusual code detected at compile
                        time.
    --assume-yes-for-downloads
                        Allow Nuitka to download external code if necessary,
                        e.g. dependency walker, ccache, and even gcc on
                        Windows. To disable, redirect input from nul device,
                        e.g. "</dev/null" or "<NUL:". Default is to prompt.
    --nowarn-mnemonic=MNEMONIC
                        Disable warning for a given mnemonic. These are given
                        to make sure you are aware of certain topics, and
                        typically point to the Nuitka website. The mnemonic is
                        the part of the URL at the end, without the HTML
                        suffix. Can be given multiple times and accepts shell
                        pattern. Default empty.

  Immediate execution after compilation:
    --run               Execute immediately the created binary (or import the compiled module). Defaults to off.
    --debugger          Execute inside a debugger, e.g. "gdb" or "lldb" to automatically get a stack trace. The debugger is automatically chosen unless specified by name with the NUITKA_DEBUGGER_CHOICE environment variable. Defaults to off.


  Output choices:
    --output-filename=FILENAME
                        Specify how the executable should be named. For
                        extension modules there is no choice, also not for
                        standalone mode and using it will be an error. This
                        may include path information that needs to exist
                        though. Defaults to '<program_name>.exe' on this
                        platform.
    --output-dir=DIRECTORY
                        Specify where intermediate and final output files
                        should be put. The DIRECTORY will be populated with
                        build folder, dist folder, binaries, etc. Defaults to
                        current directory.
    --remove-output     Removes the build directory after producing the module
                        or exe file. Defaults to off.
    --no-pyi-file       Do not create a '.pyi' file for extension modules
                        created by Nuitka. This is used to detect implicit
                        imports. Defaults to off.
    --no-pyi-stubs      Do not use stubgen when creating a '.pyi' file for
                        extension modules created by Nuitka. They expose your
                        API, but stubgen may cause issues. Defaults to off.

  


  Debug features:
    --debug             Executing all self checks possible to find errors in
                        Nuitka, do not use for production. Defaults to off.
    --no-debug-immortal-assumptions
                        Disable check normally done with "--debug". With
                        Python3.12+ do not check known immortal object
                        assumptions. Some C libraries corrupt them. Defaults
                        to check being made if "--debug" is on.
    --unstripped        Keep debug info in the resulting object file for
                        better debugger interaction. Defaults to off.
    --profile           Enable vmprof based profiling of time spent. Not
                        working currently. Defaults to off.
    --trace-execution   Traced execution output, output the line of code
                        before executing it. Defaults to off.
    --xml=XML_FILENAME  Write the internal program structure, result of
                        optimization in XML form to given filename.
    --experimental=FLAG
                        Use features declared as 'experimental'. May have no
                        effect if no experimental features are present in the
                        code. Uses secret tags (check source) per experimented
                        feature.
    --low-memory        Attempt to use less memory, by forking less C
                        compilation jobs and using options that use less
                        memory. For use on embedded machines. Use this in case
                        of out of memory problems. Defaults to off.
    --create-environment-from-report=CREATE_ENVIRONMENT_FROM_REPORT
                        Create a new virtualenv in that non-existing path from
                        the report file given with e.g. '--report=compilation-
                        report.xml'. Default not done.
    --generate-c-only   Generate only C source code, and do not compile it to
                        binary or module. This is for debugging and code
                        coverage analysis that doesn't waste CPU. Defaults to
                        off. Do not think you can use this directly.

  Nuitka Development features:
    --devel-missing-code-helpers
                        Report warnings for code helpers for types that were
                        attempted, but don't exist. This helps to identify
                        opportunities for improving optimization of generated
                        code from type knowledge not used. Default False.
    --devel-missing-trust
                        Report warnings for imports that could be trusted, but
                        currently are not. This is to identify opportunities
                        for improving handling of hard modules, where this
                        sometimes could allow more static optimization.
                        Default False.
    --devel-recompile-c-only
                        This is not incremental compilation, but for Nuitka
                        development only. Takes existing files and simply
                        compiles them as C again after doing the Python steps.
                        Allows compiling edited C files for manual debugging
                        changes to the generated source. Allows us to add
                        printing, check and print values, but it is now what
                        users would want. Depends on compiling Python source
                        to determine which files it should look at.
    --devel-internal-graph
                        Create graph of optimization process internals, do not
                        use for whole programs, but only for small test cases.
                        Defaults to off.

  Cache Control:
    --disable-cache=DISABLED_CACHES
                        Disable selected caches, specify "all" for all cached.
                        Currently allowed values are:
                        "all","ccache","bytecode","compression","dll-
                        dependencies". can be given multiple times or with
                        comma separated values. Default none.
    --clean-cache=CLEAN_CACHES
                        Clean the given caches before executing, specify "all"
                        for all cached. Currently allowed values are:
                        "all","ccache","bytecode","compression","dll-
                        dependencies". can be given multiple times or with
                        comma separated values. Default none.
    --force-dll-dependency-cache-update
                        For an update of the dependency walker cache. Will
                        result in much longer times to create the distribution
                        folder, but might be used in case the cache is suspect
                        to cause errors or known to need an update.

  PGO compilation choices:
    --pgo-c             Enables C level profile guided optimization (PGO), by
                        executing a dedicated build first for a profiling run,
                        and then using the result to feedback into the C
                        compilation. Note: This is experimental and not
                        working with standalone modes of Nuitka yet. Defaults
                        to off.
    --pgo-args=PGO_ARGS
                        Arguments to be passed in case of profile guided
                        optimization. These are passed to the special built
                        executable during the PGO profiling run. Default
                        empty.
    --pgo-executable=PGO_EXECUTABLE
                        Command to execute when collecting profile
                        information. Use this only, if you need to launch it
                        through a script that prepares it to run. Default use
                        created program.

  Tracing features:
    --report=REPORT_FILENAME
                        Report module, data files, compilation, plugin, etc.
                        details in an XML output file. This is also super
                        useful for issue reporting. These reports can e.g. be
                        used to re-create the environment easily using it with
                        '--create-environment-from-report', but contain a lot
                        of information. Default is off.
    --report-diffable   Report data in diffable form, i.e. no timing or memory
                        usage values that vary from run to run. Default is
                        off.
    --report-user-provided=KEY_VALUE
                        Report data from you. This can be given multiple times
                        and be anything in 'key=value' form, where key should
                        be an identifier, e.g. use '--report-user-
                        provided=pipenv-lock-hash=64a5e4' to track some input
                        values. Default is empty.
    --report-template=REPORT_DESC
                        Report via template. Provide template and output
                        filename 'template.rst.j2:output.rst'. For built-in
                        templates, check the User Manual for what these are.
                        Can be given multiple times. Default is empty.
    --quiet             Disable all information outputs, but show warnings. Defaults to off.
    --show-scons        Run the C building backend Scons with verbose
                        information, showing the executed commands, detected
                        compilers. Defaults to off.
    --no-progressbar    Disable progress bars. Defaults to off.
    --show-progress     Obsolete: Provide progress information and statistics.
                        Disables normal progress bar. Defaults to off.
    --show-memory       Provide memory information and statistics. Defaults to
                        off.
    --show-modules      Provide information for included modules and DLLs
                        Obsolete: You should use '--report' file instead.
                        Defaults to off.
    --show-modules-output=PATH
                        Where to output '--show-modules', should be a
                        filename. Default is standard output.
    --verbose           Output details of actions taken, esp. in
                        optimizations. Can become a lot. Defaults to off.
    --verbose-output=PATH
                        Where to output from '--verbose', should be a
                        filename. Default is standard output.

  

  

  macOS specific controls:
    --macos-create-app-bundle
                        When compiling for macOS, create a bundle rather than
                        a plain binary application. This is the only way to
                        unlock the disabling of console, get high DPI
                        graphics, etc. and implies standalone mode. Defaults
                        to off.
    --macos-target-arch=MACOS_TARGET_ARCH
                        What architectures is this to supposed to run on.
                        Default and limit is what the running Python allows
                        for. Default is "native" which is the architecture the
                        Python is run with.
    --macos-app-icon=ICON_PATH
                        Add icon for the application bundle to use. Can be
                        given only one time. Defaults to Python icon if
                        available.
    --macos-signed-app-name=MACOS_SIGNED_APP_NAME
                        Name of the application to use for macOS signing.
                        Follow "com.YourCompany.AppName" naming results for
                        best results, as these have to be globally unique, and
                        will potentially grant protected API accesses.
    --macos-app-name=MACOS_APP_NAME
                        Name of the product to use in macOS bundle
                        information. Defaults to base filename of the binary.
    --macos-app-mode=APP_MODE
                        Mode of application for the application bundle. When
                        launching a Window, and appearing in Docker is
                        desired, default value "gui" is a good fit. Without a
                        Window ever, the application is a "background"
                        application. For UI elements that get to display
                        later, "ui-element" is in-between. The application
                        will not appear in dock, but get full access to
                        desktop when it does open a Window later.
    --macos-sign-identity=MACOS_APP_VERSION
                        When signing on macOS, by default an ad-hoc identify
                        will be used, but with this option your get to specify
                        another identity to use. The signing of code is now
                        mandatory on macOS and cannot be disabled. Use "auto"
                        to detect your only identity installed. Default "ad-
                        hoc" if not given.
    --macos-sign-notarization
                        When signing for notarization, using a proper TeamID
                        identity from Apple, use the required runtime signing
                        option, such that it can be accepted.
    --macos-app-version=MACOS_APP_VERSION
                        Product version to use in macOS bundle information.
                        Defaults to "1.0" if not given.
    --macos-app-protected-resource=RESOURCE_DESC
                        Request an entitlement for access to a macOS protected
                        resources, e.g.
                        "NSMicrophoneUsageDescription:Microphone access for
                        recording audio." requests access to the microphone
                        and provides an informative text for the user, why
                        that is needed. Before the colon, is an OS identifier
                        for an access right, then the informative text. Legal
                        values can be found on https://developer.apple.com/doc
                        umentation/bundleresources/information_property_list/p
                        rotected_resources and the option can be specified
                        multiple times. Default empty.

  Linux specific controls:
    --linux-icon=ICON_PATH
                        Add executable icon for onefile binary to use. Can be
                        given only one time. Defaults to Python icon if
                        available.

  Binary Version Information:
    --company-name=COMPANY_NAME
                        Name of the company to use in version information.
                        Defaults to unused.
    --product-name=PRODUCT_NAME
                        Name of the product to use in version information.
                        Defaults to base filename of the binary.
    --file-version=FILE_VERSION
                        File version to use in version information. Must be a
                        sequence of up to 4 numbers, e.g. 1.0 or 1.0.0.0, no
                        more digits are allowed, no strings are allowed.
                        Defaults to unused.
    --product-version=PRODUCT_VERSION
                        Product version to use in version information. Same
                        rules as for file version. Defaults to unused.
    --file-description=FILE_DESCRIPTION
                        Description of the file used in version information.
                        Windows only at this time. Defaults to binary
                        filename.
    --copyright=COPYRIGHT_TEXT
                        Copyright used in version information. Windows/macOS
                        only at this time. Defaults to not present.
    --trademarks=TRADEMARK_TEXT
                        Trademark used in version information. Windows/macOS
                        only at this time. Defaults to not present.

  Plugin control:
    --enable-plugins=PLUGIN_NAME
                        Enabled plugins. Must be plug-in names. Use '--plugin-
                        list' to query the full list and exit. Default empty.
    --disable-plugins=PLUGIN_NAME
                        Disabled plugins. Must be plug-in names. Use '--
                        plugin-list' to query the full list and exit. Most
                        standard plugins are not a good idea to disable.
                        Default empty.
    --user-plugin=PATH  The file name of user plugin. Can be given multiple
                        times. Default empty.
    --plugin-list       Show list of all available plugins and exit. Defaults
                        to off.
    --plugin-no-detection
                        Plugins can detect if they might be used, and the you
                        can disable the warning via "--disable-plugin=plugin-
                        that-warned", or you can use this option to disable
                        the mechanism entirely, which also speeds up
                        compilation slightly of course as this detection code
                        is run in vain once you are certain of which plugins
                        to use. Defaults to off.
    --module-parameter=MODULE_PARAMETERS
                        Provide a module parameter. You are asked by some
                        packages to provide extra decisions. Format is
                        currently --module-parameter=module.name-option-
                        name=value Default empty.
    --show-source-changes=SHOW_SOURCE_CHANGES
                        Show source changes to original Python file content
                        before compilation. Mostly intended for developing
                        plugins and Nuitka package configuration. Use e.g. '--
                        show-source-changes=numpy.**' to see all changes below
                        a given namespace or use '*' to see everything which
                        can get a lot. Default empty.

  Cross compilation:
    --target=TARGET_DESC
                        Cross compilation target. Highly experimental and in
                        development, not supposed to work yet. We are working
                        on '--target=wasi' and nothing else yet.

  Plugin options of 'anti-bloat' (categories: core):
    --show-anti-bloat-changes
                        Annotate what changes are done by the plugin.
    --noinclude-setuptools-mode=NOINCLUDE_SETUPTOOLS_MODE
                        What to do if a 'setuptools' or import is encountered.
                        This package can be big with dependencies, and should
                        definitely be avoided. Also handles 'setuptools_scm'.
    --noinclude-pytest-mode=NOINCLUDE_PYTEST_MODE
                        What to do if a 'pytest' import is encountered. This
                        package can be big with dependencies, and should
                        definitely be avoided. Also handles 'nose' imports.
    --noinclude-unittest-mode=NOINCLUDE_UNITTEST_MODE
                        What to do if a unittest import is encountered. This
                        package can be big with dependencies, and should
                        definitely be avoided.
    --noinclude-pydoc-mode=NOINCLUDE_PYDOC_MODE
                        What to do if a pydoc import is encountered. This
                        package use is mark of useless code for deployments
                        and should be avoided.
    --noinclude-IPython-mode=NOINCLUDE_IPYTHON_MODE
                        What to do if a IPython import is encountered. This
                        package can be big with dependencies, and should
                        definitely be avoided.
    --noinclude-dask-mode=NOINCLUDE_DASK_MODE
                        What to do if a 'dask' import is encountered. This
                        package can be big with dependencies, and should
                        definitely be avoided.
    --noinclude-numba-mode=NOINCLUDE_NUMBA_MODE
                        What to do if a 'numba' import is encountered. This
                        package can be big with dependencies, and is currently
                        not working for standalone. This package is big with
                        dependencies, and should definitely be avoided.
    --noinclude-default-mode=NOINCLUDE_DEFAULT_MODE
                        This actually provides the default "warning" value for
                        above options, and can be used to turn all of these
                        on.
    --noinclude-custom-mode=CUSTOM_CHOICES
                        What to do if a specific import is encountered. Format
                        is module name, which can and should be a top level
                        package and then one choice, "error", "warning",
                        "nofollow", e.g. PyQt5:error.

  Plugin options of 'playwright' (categories: package-support):
    --playwright-include-browser=INCLUDE_BROWSERS
                        Playwright browser to include by name. Can be
                        specified multiple times. Use "all" to include all
                        installed browsers or use "none" to exclude all
                        browsers.

  Plugin options of 'spacy' (categories: package-support):
    --spacy-language-model=INCLUDE_LANGUAGE_MODELS
                        Spacy language models to use. Can be specified
                        multiple times. Use 'all' to include all downloaded
                        models.
