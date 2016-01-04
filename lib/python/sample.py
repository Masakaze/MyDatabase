# -*- coding: utf-8 -*-

#
# @author Masakaze Sato
# @brief pythonのサンプルスクリプト
#

import os
import datetime

if __name__ == '__main__':
    tmp_file = os.path.join(os.path.dirname(__file__), "sample.txt")
    print("file out start")
    with open(tmp_file, "w") as fout:
        fout.write(datetime.datetime.now().strftime("%Y/%m/%d %H:%M:%S"))
    print("file out end")

    print("file read start")
    with open(tmp_file, "r") as fin:
        print(fin.read())
    print("file read end")

    
