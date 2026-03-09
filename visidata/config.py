import sys
import os
from pathlib import Path

s_config_dir = Path("~/.config/visidata/")
s_config_dirpath = s_config_dir.expanduser()

sys.path.insert(0, str(s_config_dirpath))

s_venv_path = Path("~/venv/bin/activate").expanduser()

if sys.executable != s_venv_path:
    os.execl(s_venv_path, s_venv_path, *sys.argv)

import dedupe
import guess_type
import pandas
import pyarrow
from confidence_intervals import ci95, ci95_lower, ci95_upper

options.quitguard = True
options.save_filetype = "tsv"
options.color_key_col = "114 green"
options.default_width = 30
options.force_256_colors = False
options.disp_float_fmt = "{:.4f}"

vd.aggregator("ci95", ci95, helpstr="mean ± 95% CI (normal approx)", type=str)
vd.aggregator("ci95_lower", ci95_lower, type=float)
vd.aggregator("ci95_upper", ci95_upper, type=float)
