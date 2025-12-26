import subprocess
import sys
import unittest

class TestCompileAll(unittest.TestCase):
    def test_compileall(self):
        r = subprocess.run([sys.executable, "-m", "compileall", "-q", "."], capture_output=True, text=True)
        if r.returncode != 0:
            self.fail(r.stderr or r.stdout or "compileall failed")

if __name__ == "__main__":
    unittest.main()
