import math
import statistics


def ci95(values):
    vals = list(values)
    if len(vals) < 2:
        return None
    mean = sum(vals) / len(vals)
    se = statistics.stdev(vals) / math.sqrt(len(vals))
    z = 1.96
    return f"{mean:.4f} ± {z*se:.4f}"


def ci95_lower(values):
    vals = list(values)
    if len(vals) < 2:
        return None
    m = sum(vals) / len(vals)
    se = statistics.stdev(vals) / math.sqrt(len(vals))
    return m - 1.96 * se


def ci95_upper(values):
    vals = list(values)
    if len(vals) < 2:
        return None
    m = sum(vals) / len(vals)
    se = statistics.stdev(vals) / math.sqrt(len(vals))
    return m + 1.96 * se
