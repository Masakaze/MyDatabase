#
# @brief	TaskDB全体のテスト
# @note		task_dbフォルダに細かくファイル分けしてます
# @note		「-e キーワード」オプションでitを部分実行できるみたいだけど、早くなるかはその時によりそう
#

require 'spec_helper'

$:.unshift(File.join( File.dirname(__FILE__), "task_db") )
require "task_infos_show_spec"
require "task_infos_index_spec"
require "task_infos_new_spec"
require "task_infos_read_reminder_spec"

require "task_category_new_spec"



