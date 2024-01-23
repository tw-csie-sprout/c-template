#include <bits/stdc++.h>
#include <cassert>
#include <cstdlib>

using namespace std;

// first arg is for the upper bound of a and b, and the second one is the random seed.
int main (int argc, char** argv) {
  assert(argc == 3);

  mt19937 gen(atoi(argv[2]));
  uniform_int_distribution<> dist(0, atoi(argv[1]));

  cout << dist(gen) << ' ' << dist(gen) << '\n';

  return 0;
}
