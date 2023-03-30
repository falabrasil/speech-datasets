#!/usr/bin/env python3
#
# receives a timelist from stdin genereated in `soxi -d` format and sums the
# times up to give total duration in hours
#
# author: mar 2023
# cassio batista - https://cassiotbatista.github.io

import sys
import os
import re
from datetime import timedelta

# FIXME not sure what condition to check in order to print this usage message
def usage():
    print("usage: %s <duration-list>" % sys.argv[0])
    print("  <duration-list> is a list of duration that comes from soxi")
    print("  e.g.: find DATA_DIR -name '*.wav' | xargs soxi -d | soxi2hours.py")
    sys.exit(1)


if __name__ == "__main__":

    t = timedelta(seconds=0)
    try:
        for line in iter(sys.stdin):
            line = line.strip()
            m, s = re.match(r"^(\d+)m:(\d+\.\d+)s$", line).groups()
            t += timedelta(seconds=int(m) * 60 + float(s))
    except KeyboardInterrupt:
        print(" **kbd interrupted")
        pass
    except AttributeError:
        print(fr"is this time from opusinfo? {line}", file=sys.stderr)
        sys.exit(1)
    s = t.total_seconds()
    h, m = divmod(s, 3600)
    m, _ = divmod(m, 60)
    print("%3dh%02dm" % (h, m))
