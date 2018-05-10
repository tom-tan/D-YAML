
//          Copyright Ferdinand Majerech 2011-2014
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module dyaml.test.errors;


version(unittest)
{

import std.file;

import dyaml.test.common;


/// Loader error unittest from file stream.
///
/// Params:  errorFilename = File name to read from.
void testLoaderError(string errorFilename) @safe
{
    auto buffer = std.file.read(errorFilename);

    Node[] nodes;
    try { nodes = Loader(buffer).loadAll(); }
    catch(YAMLException e)
    {
        printException(e);
        return;
    }
    assert(false, "Expected an exception");
}

/// Loader error unittest from string.
///
/// Params:  errorFilename = File name to read from.
void testLoaderErrorString(string errorFilename) @safe
{
    // Load file to a buffer, then pass that to the YAML loader.
    auto buffer = std.file.read(errorFilename);

    try
    {
        auto nodes = Loader(buffer).loadAll();
    }
    catch(YAMLException e)
    {
        printException(e);
        return;
    }
    assert(false, "Expected an exception");
}

/// Loader error unittest from filename.
///
/// Params:  errorFilename = File name to read from.
void testLoaderErrorFilename(string errorFilename) @safe
{
    try { auto nodes = Loader(errorFilename).loadAll(); }
    catch(YAMLException e)
    {
        printException(e);
        return;
    }
    assert(false, "testLoaderErrorSingle(" ~ ", " ~ errorFilename ~
                 ") Expected an exception");
}

/// Loader error unittest loading a single document from a file.
///
/// Params:  errorFilename = File name to read from.
void testLoaderErrorSingle(string errorFilename) @safe
{
    try { auto nodes = Loader(errorFilename).load(); }
    catch(YAMLException e)
    {
        printException(e);
        return;
    }
    assert(false, "Expected an exception");
}

@safe unittest
{
    printProgress("D:YAML Errors unittest");
    run("testLoaderError",         &testLoaderError,         ["loader-error"]);
    run("testLoaderErrorString",   &testLoaderErrorString,   ["loader-error"]);
    run("testLoaderErrorFilename", &testLoaderErrorFilename, ["loader-error"]);
    run("testLoaderErrorSingle",   &testLoaderErrorSingle,   ["single-loader-error"]);
}

} // version(unittest)
