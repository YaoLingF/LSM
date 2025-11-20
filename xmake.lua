-- 定义项目
set_project("ylf-lsm")
set_version("0.0.1")
set_languages("c++20")

add_rules("mode.debug", "mode.release")

add_repositories("local-repo build")

add_requires("gtest")
add_requires("muduo")
add_requires("pybind11")
add_requires("spdlog", { system = false })
add_requires("toml11", { system = false })

target("logger")
    set_kind("static")  -- 生成静态库
    add_files("src/logger/*.cpp")
    add_packages("spdlog")
    add_includedirs("include", {public = true})
    
target("config")
    set_kind("static")  -- 生成静态库
    add_files("src/config/*.cpp")
    add_packages("toml11", "spdlog")
    add_includedirs("include", {public = true})

target("iterator")
    set_kind("static")  -- 生成静态库
    add_files("src/iterator/*.cpp")
    add_packages("toml11", "spdlog")
    add_includedirs("include", {public = true})

target("skiplist")
    set_kind("static")  -- 生成静态库
    add_files("src/skiplist/*.cpp")
    add_packages("toml11", "spdlog")
    add_includedirs("include", {public = true})

    
target("memtable")
    set_kind("static")  -- 生成静态库
    add_deps("skiplist","iterator", "config")
    --add_deps("sst")
    add_packages("toml11", "spdlog")
    add_files("src/memtable/*.cpp")
    add_includedirs("include", {public = true})

target("block")
    set_kind("static")  -- 生成静态库
    add_deps("config")
    add_files("src/block/*.cpp")
    add_packages("toml11", "spdlog")
    add_includedirs("include", {public = true})

target("test_skiplist")
    set_kind("binary")  -- 生成可执行文件
    set_group("tests")
    add_files("test/test_skiplist.cpp")
    add_deps("logger", "skiplist")  -- 依赖skiplist库
    add_packages("gtest")  -- 添加gtest包
    add_packages("toml11", "spdlog")

target("test_memtable")
    set_kind("binary")
    set_group("tests")
    add_files("test/test_memtable.cpp")
    add_deps("logger", "memtable")  -- 如果memtable是独立的target，这里需要添加对应的依赖
    add_packages("gtest")
    add_packages("toml11", "spdlog")
    add_includedirs("include")

target("test_block")
    set_kind("binary")
    set_group("tests")
    add_files("test/test_block.cpp")
    add_deps("logger", "block")
    add_packages("gtest")
    add_packages("toml11", "spdlog")
    add_includedirs("include")


target("test_blockmeta")
    set_kind("binary")
    set_group("tests")
    add_files("test/test_blockmeta.cpp")
    add_deps("logger", "block")  -- 如果memtable是独立的target，这里需要添加对应的依赖
    add_packages("gtest")
    add_packages("toml11", "spdlog")
    add_includedirs("include")