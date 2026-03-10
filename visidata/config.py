import sys
from pathlib import Path

# Add config dir to path to import local modules like confidence_intervals
s_config_dirpath = Path("~/.config/visidata/").expanduser()
sys.path.insert(0, str(s_config_dirpath))

# Imports (ensure these are installed in your venv)
import dedupe
import guess_type
import pandas
import pyarrow
from confidence_intervals import ci95, ci95_lower, ci95_upper

# Options
options.quitguard = True
options.save_filetype = "tsv"
options.color_key_col = "114 green"
options.default_width = 30
options.force_256_colors = False
options.disp_float_fmt = "{:.4f}"

# Aggregators
vd.aggregator("mean_ci95", ci95, type=str)
vd.aggregator("mean_ci95_lower", ci95_lower, type=float)
vd.aggregator("mean_ci95_upper", ci95_upper, type=float)
