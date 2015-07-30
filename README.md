readium-example-20150729
========================

This is a severely reduced example of how we're attempting to build
Readium. We use the "standalone compiler" tool provided by the NDK to
compile each source file of Readium in turn using a set of extremely
explicit and direct Makefile rules. We build the Adobe Adept Connector
in the same manner, bypassing their rather baroque build system for
something that behaves identically across different platforms. We do
this partly because it avoids having to use the extremely complex,
recursive, and basically un-debuggable Android NDK `ndk-build`
Makefiles, and partly because we need to override a few things in the
way Readium is built (the Adept Connector forces us to use a slightly
custom build of OpenSSL, and we'd need to use that same build in both
Readium and Adept).

The steps to build are as follows:

0. Set `ANDROID_SDK_HOME` and `ANDROID_NDK_HOME` to the locations
   of your SDK and NDK.

1. Place a copy of the readium sources at `./readium-sdk`. In my
   case, I use a symbolic link to the checked out git repository:

```
  $ ln -s $HOME/git/com.github/readium/readium-sdk readium-sdk
  $ ls readium-sdk/
    BuildTools
    MakeHeaders.js
    MakeHeaders.sh
    Platform
    Readme.markdown
    TestData
    UnitTests
    api-docs
    ePub3
    ePub3-iOS
    license.txt
```

   We'll replace this with something slightly more intelligent
   such as git submodules later.

3. Run `./android-toolchains-make.sh`. This uses the NDK's
   standalone compiler feature (see the NDK docs -
   `Building → Standalone Toolchain → Invoking the compiler (the easy way)`)

4. Run `make -f Makefile.android`

5. Be buried under compilation errors.

Currently, the compiler flags produced by `./android-includes.sh`
are obviously not correct: I was in the process of figuring out
which directories needed to be included when I discovered the NDK 9
issue.

