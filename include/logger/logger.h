#pragma once

#include <string>

namespace ylf_lsm {

void init_spdlog_file();
void reset_log_level(const std::string &level);

} 