-- 定义项目
set_project("toni-lsm")
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


target("test_skiplist")
    set_kind("binary")  -- 生成可执行文件
    set_group("tests")
    add_files("test/test_skiplist.cpp")
    add_deps("logger", "skiplist")  -- 依赖skiplist库
    add_packages("gtest")  -- 添加gtest包
    add_packages("toml11", "spdlog")
