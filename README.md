## Example files for the title:

# lex & yacc 2nd Edition, by Doug Brown

[original README.md is here](README-orig.md)

As someone who was four years old when the first edition was released it
is quite amazing to see how far we have come since then. The preface has
instructions to download the sources from UUNET.

Anyway, this repository revamps the example code and the corresponding
[Makefile](Makefile) and adds files to build with Bazel. In this
particular case, Bazel is overkill (unless hermeticity is a requirement)
because Make takes less than a second with 16 cores. Overview:

* there were a lot of warnings some of which are treated as errors by
default:
    * [-Wimplicit-int](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-int)
    * [-Wimplicit-function-declaration](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-function-declaration)
    * [-Wold-style-definition](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wold-style-definition)
    * [-Wbuiltin-declaration-mismatch](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wbuiltin-declaration-mismatch
    * `-Wunused-function` could generally be fixed by adding the
    appropriate `%options` line
* the build system was a mess
    * Make was not parallelizable, i.e. `--jobs=N` with `N > 1` would
      not work: Generating `y.tab.{c,h}` and subsequently moving them
      would result in a lot of conflicts
    * Even if that wasn't a problem, the `Makefile` would not allow for
      best parallelization due to grouping `flex`, `bison` and `cc` in
      one rule: there should be one action per rule
    * The `Makefile` could use more [implicit rules](https://www.gnu.org/software/make/manual/html_node/Implicit-Rules.html)
    * The `Makefile` still had [old-fashioned suffix rules](https://www.gnu.org/software/make/manual/html_node/Suffix-Rules.html)
* In general warnings should be treated as errors

That being said, I do understand that considering more than a single
core was just not relevant in 1990 and the C-style also had an evolution
over all these years.

I think there are at least two anti-patterns:

* mixing code with lexer and parser: the user subroutine section should
  be empty
    * adhering to that rule makes [switching languages](https://www.gnu.org/software/bison/manual/html_node/Other-Languages.html)
    much easier
* relying on default implementations for `main()` and `yywrap()` - among
  others - from `libfl` is also not ideal
    * not all environments have/make a `libfl` available

## Building

```sh
make VERBOSE=1 --jobs=$(nproc) CC=gcc CXX=g++
make VERBOSE=1 --jobs=$(nproc) CC=clang CXX=clang++
bazel build --subcommands=pretty_print ...
```

## Tested with

* Bison 3.8.2
* Flex 2.6.4
* GCC 14 and 15
* Clang 21
* Make 4.4.1
* Bazel 8.6.0rc1 (not 9.0.0 because `rules_m4` is incompatible)

## References

* [bison: A simple C++ examle](https://www.gnu.org/software/bison/manual/html_node/A-Simple-C_002b_002b-Example.html)
* [flex: Options](https://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC17)
* [flex: Generating C++ Scanners](https://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC19)
* [flex: Incompatibilities with lex and POSIX](https://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC20)
* [flex: Makefiles and Flex](https://westes.github.io/flex/manual/Makefiles-and-Flex.html#Makefiles-and-Flex)
