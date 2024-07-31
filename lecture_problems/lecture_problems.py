from ortools.linear_solver import pywraplp

# Lecture example: LP
# A simple two decision problem for factory output.

solver = pywraplp.Solver(
    name="factory-lp", problem_type=pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)
inf = solver.infinity()

# entities
I = {"s", "p"}

# parameters
t_i = {"s": 1.5, "p": 2.}
P_i = {"s": 125., "p": 200.}
T = 40.

# decision variables
y_i = {}
y_i["s"] = solver.NumVar(lb=10., ub=inf, name="y_s")
y_i["p"] = solver.NumVar(lb=0., ub=inf, name="y_p")

# objective value
solver.Maximize(solver.Sum(P_i[i] * y_i[i] for i in I))

# constraints
_ = solver.Add(solver.Sum(t_i[i] * y_i[i] for i in I) <= T)

# run solver
solver.Solve()

obj = solver.Objective().Value()

y_s = y_i["s"].SolutionValue()
y_p = y_i["p"].SolutionValue()

print(f"Optimal solution makes {
      y_s} of standard product and {y_p} of premium product.")
print(f"Optimal objective value = £{obj}")

# Lecture example: MILP
solver = pywraplp.Solver(
    name="factory-milp", problem_type=pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)
inf = solver.infinity()

# entities
I = {"s", "p"}

# parameters
t_i = {"s": 1.5, "p": 2.}
P_i = {"s": 125., "p": 200.}
T = 40.

# decision variables
y_i = {}
y_i["s"] = solver.IntVar(lb=10., ub=inf, name="y_s")
y_i["p"] = solver.IntVar(lb=0., ub=inf, name="y_p")

# objective value
solver.Maximize(solver.Sum(P_i[i] * y_i[i] for i in I))

# constraints
_ = solver.Add(solver.Sum(t_i[i] * y_i[i] for i in I) <= T)

# run solver
solver.Solve()

obj = solver.Objective().Value()

y_s = y_i["s"].SolutionValue()
y_p = y_i["p"].SolutionValue()

print(f"Optimal solution makes {
      y_s} of standard product and {y_p} of premium product.")
print(f"Optimal objective value = £{obj}")

# Lecture example: MILP with startup costs

solver = pywraplp.Solver(name="factory-startup",
                         problem_type=pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)
inf = solver.infinity()

# entitities
I = {"s", "p", "e"}

# parameters
t_i = {"s": 1.5, "p": 2., "e": 2.5}
P_i = {"s": 125., "p": 200., "e": 275.}
T = 40.
C_e = 500.
M = 1000  # big-M

# decision variables
y_i = {}
y_i["s"] = solver.IntVar(lb=10, ub=inf, name="y_s")
y_i["p"] = solver.IntVar(lb=0, ub=inf, name="y_p")
y_i["e"] = solver.IntVar(lb=0, ub=inf, name="y_e")
delta = solver.IntVar(lb=0, ub=1, name="delta")

# objective value
solver.Maximize(solver.Sum(P_i[i] * y_i[i] for i in I) - C_e * delta)

# constraints
_ = solver.Add(solver.Sum(t_i[i] * y_i[i] for i in I) <= T)
_ = solver.Add(M * delta >= y_i["e"])

# run solver
solver.Solve()

obj = solver.Objective().Value()

y_s = y_i["s"].SolutionValue()
y_p = y_i["p"].SolutionValue()
y_e = y_i["e"].SolutionValue()

print(f"Optimal solution makes {y_s} of standard product, {y_p} of premium product"
      f" and {y_e} of extra premium product.")
print(f"Optimal objective value = £{obj}")
