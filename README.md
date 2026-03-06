# Numerical Methods — Class Notes — 2021.02 

---

# 1. Root Finding

## 1.1 Existence Theorem

Let $f:[a,b] \rightarrow \mathbb{R}$ be a **continuous** function.

If

$$f(a)f(b) < 0$$

then there exists **at least one** $x \in [a,b]$ such that

$$f(x) = 0$$

> **note:** *"If f(a)f(b)<0, the Existence Theorem applies."*

**Why this works:** The condition $f(a)f(b) < 0$ means $f(a)$ and $f(b)$ have **opposite signs**. Since $f$ is continuous on a closed interval, by the **Intermediate Value Theorem** it must pass through zero at least once. Geometrically, the curve must cross the x-axis if it starts on one side and ends on the other.

---

### 1.2 Uniqueness Theorem

Under the same hypothesis, if $f'(x)$ **exists and preserves its sign** throughout $[a,b]$, then there is **exactly one root** in the interval.

> **note:** *"If f'(x) exists and preserves sign in the interval, the interval contains ONE UNIQUE zero of f(x)."*

**Why this works:** A sign-preserving derivative means $f$ is **strictly monotone** (either always increasing or always decreasing). A strictly monotone function can cross any horizontal line — including $y=0$ — **at most once**. Combined with the existence theorem, this guarantees exactly one crossing.

---

## 1.3 Stopping Criteria

Two standard criteria for declaring a root found:

**Criterion 1 — Function tolerance:**

$$|f(x_k)| \leq \epsilon$$

$x_k$ is considered the root if the function value is sufficiently close to zero.

**Criterion 2 — Interval tolerance:**

$$b - a < \epsilon$$

If the containing interval is sufficiently small, $x_k$ is an acceptable approximation.

> **note:** *"ε is the tolerance / precision of the solution."*

**Practical note:** Criterion 1 checks how close $f$ is to zero; Criterion 2 checks how precisely the root's location is known. They are complementary — a function with a very shallow slope near the root may satisfy Criterion 2 long before Criterion 1, and vice versa for steep functions.

---

# 2. Interval Methods

These methods require an initial bracket $[a,b]$ satisfying $f(a)f(b)<0$.

---

## 2.1 Incremental Search

> **note:** *"For each value x, increment until the sign of f(x) changes (stopping criterion). When a sign change occurs, the Existence Theorem applies."*

**Algorithm concept:**

1. Start at $x = a$
2. Increment by step $h$: $x_{i+1} = x_i + h$
3. Check sign change: $f(x_i) \cdot f(x_{i+1}) < 0$
4. When detected, the root lies in $[x_i, x_{i+1}]$

**Variants:**
- Fix $a$ and increase only $b$ until the sign changes
- Define a maximum number of iterations

**Trade-off:** Smaller $h$ gives more precision but requires more evaluations. This method is typically used as a **preliminary scan** before a more refined method is applied.

---

## 2.2 Bisection Method

Based directly on the **Existence Theorem**.

At each iteration, compute the midpoint:

$$m = \frac{a + b}{2}$$

Update the interval:

$$[a, m] \quad \text{if} \quad f(a)f(m) < 0$$

$$[m, b] \quad \text{otherwise}$$

> **note:** *"Each iteration divides the interval [a,b]. meio = a+b/2."*

**Convergence analysis:** After $k$ iterations the interval has length:

$$|b_k - a_k| = \frac{b - a}{2^k}$$

The root is guaranteed to be found within this interval. The number of iterations needed to achieve tolerance $\epsilon$ is:

$$k \geq \frac{\ln(b-a) - \ln(\epsilon)}{\ln 2}$$

**Strengths:** Simple, robust, always converges.  
**Weaknesses:** Slow (linear convergence); halves the interval each step regardless of function shape.

---

## 2.3 False Position Method (Regula Falsi)

Instead of the midpoint, use the **x-intercept of the secant line** connecting $(a, f(a))$ and $(b, f(b))$.

$$x_k = \frac{a \cdot f(b) - b \cdot f(a)}{f(b) - f(a)}$$

> **note:** *"x_k is the root of the line through the interval points; derived from solving a linear system."*

**Derivation:** The line through $(a, f(a))$ and $(b, f(b))$ has equation:

$$y - f(a) = \frac{f(b)-f(a)}{b-a}(x - a)$$

Setting $y = 0$ and solving for $x$ gives the formula above.

**New interval:**

$$[a, x_k] \quad \text{if} \quad f(a)f(x_k) < 0$$

$$[x_k, b] \quad \text{otherwise}$$

**Comparison with Bisection:** False position tends to converge faster because it exploits the function's slope. However, for highly asymmetric functions one endpoint can remain fixed for many iterations (a known weakness called **stagnation**).

---

# 3. Open Methods

Open methods do **not** require a bracket. They may diverge, but when they converge, they do so much faster.

---

## 3.1 Newton's Method

Start with an initial guess $x_0$.

$$x_{k+1} = x_k - \frac{f(x_k)}{f'(x_k)}$$

> **note:** *"x_k is the intersection point of the x-axis with the tangent line at x_{k-1}."*

**Derivation:** Approximate $f$ near $x_k$ with its first-order Taylor expansion:

$$f(x) \approx f(x_k) + f'(x_k)(x - x_k)$$

Setting $f(x) = 0$:

$$x = x_k - \frac{f(x_k)}{f'(x_k)}$$

**Convergence:** **Quadratic** — the number of correct digits roughly doubles each iteration near the root.

**Conditions for convergence:** The method behaves well when:
- The initial guess is close to the root
- $f'(x_k) \neq 0$ (no zero derivative)
- The function is smooth near the root

> **note:** *"There is no guarantee it will converge."*

---

## 3.2 Secant Method

Does **not require the derivative** — approximates it using two previous iterates.

Two initial guesses $x_0, x_1$ are required.

$$x_k = \frac{x_{k-2} \cdot f(x_{k-1}) - x_{k-1} \cdot f(x_{k-2})}{f(x_{k-1}) - f(x_{k-2})}$$

> **note:** *"x_k is updated to the intersection of the x-axis with the secant line through x_{k-1} and x_{k-2}. Approximates f'(x) from Newton's method using past values."*

**Connection to Newton's method:** The secant method replaces the derivative with a finite difference:

$$f'(x_{k-1}) \approx \frac{f(x_{k-1}) - f(x_{k-2})}{x_{k-1} - x_{k-2}}$$

**Convergence:** **Superlinear** (order $\approx 1.618$, the golden ratio) — slower than Newton but requires no analytical derivative.

---

# 4. Linear Systems

**Goal:** Find $x$ satisfying

$$Ax = B$$

where $A$ is a square matrix with $\det(A) \neq 0$ (nonsingular / linearly independent rows).

---

## 4.1 Elementary Row Operations

> **note:** *"GAAV — Elementary Operations."*

1. Swap two rows
2. Multiply a row by a nonzero constant $c \neq 0$
3. Add a multiple of one row to another

These operations transform the system into an **equivalent** one (same solution set) and are the foundation of all elimination methods.

---

## 4.2 Cramer's Rule

$$x_i = \frac{\det(A_i)}{\det(A)}$$

where $A_i$ is matrix $A$ with column $i$ replaced by $B$.

> **note:** *"Computationally expensive — requires n+1 determinant calculations."*

**Complexity:** $O(n!)$ in naive implementations. Impractical for large systems, but useful for deriving theoretical results.

---

## 4.3 Matrix Inverse Method

$$Ax = B \implies x = A^{-1}B$$

> **note:** *"Not efficient in computational terms; computing inverses generates numerical errors for large-dimension systems."*

Computing $A^{-1}$ explicitly costs $O(n^3)$ and accumulates **round-off errors**. Preferred only when the same $A$ must be used with many different right-hand sides $B$.

---

# 5. Direct Methods

Produce an **exact** solution (up to rounding error) in a **finite number of operations**.

---

## 5.1 Triangular Systems — $O(n^2)$

> **note:** *"Uses successive and back substitutions. Recursive solutions can be implemented since solving one row gives a partial result for the next."*

### Lower Triangular (Forward Substitution)

Elements **above** the diagonal are zero. Solved from top to bottom:

$$x_i = \frac{1}{a_{ii}} \left( b_i - \sum_{j=1}^{i-1} a_{ij} x_j \right)$$

### Upper Triangular (Back Substitution)

Elements **below** the diagonal are zero. Solved from bottom to top:

$$x_i = \frac{1}{a_{ii}} \left( b_i - \sum_{j=i+1}^{n} a_{ij} x_j \right)$$

---

## 5.2 Gaussian Elimination

More general method. Transforms $A$ into an **upper triangular matrix** using row operations, then solves with back substitution.

> **note:** *"Uses an augmented matrix with coefficients on the left and constants on the right. Uses elementary operations to zero elements below the main diagonal."*

**Steps:**
1. Form the augmented matrix $[A|B]$
2. For each pivot column $k$, eliminate entries below the diagonal using:
$$m_{ik} = \frac{a_{ik}}{a_{kk}}, \quad R_i \leftarrow R_i - m_{ik} R_k$$
3. Back-substitute to find the solution

**Complexity:** $O(n^3)$ for the elimination phase, $O(n^2)$ for back substitution.

---

## 5.3 Gauss–Jordan Method

Instead of stopping at upper triangular, eliminates elements **above and below** each pivot, transforming $A$ into the **identity matrix**:

$$[A|B] \rightarrow [I|x]$$

> **note:** *"Uses more steps than Gauss. No back substitution needed. Pivot cannot be zero (PIVOTING PROBLEM)."*

**When the pivot $a_{kk} = 0$:** The algorithm breaks. Pivoting strategies solve this.

---

## 5.4 Pivoting Strategies

> **note:** *"The pivot a_kk also cannot be very small, because the multiplier m can become very large, generating rounding errors."*

### Partial Pivoting

At step $k$, find the row $r$ with the largest absolute value in column $k$ at or below the diagonal:

$$|a_{rk}| = \max_{i=k..n} |a_{ik}|$$

Swap rows $k$ and $r$. This ensures:

$$|m_{ik}| \leq 1$$

keeping multipliers bounded and reducing round-off error.

### Total Pivoting

At step $k$, search the entire remaining submatrix for the largest element:

$$|a_{rs}| = \max_{\substack{i=k..n \\ j=k..n}} |a_{ij}|$$

Swap both the row and column. More numerically stable, but:

> **note:** *"High computational effort to find and swap the pivot. Column swapping affects variable ordering."*

---

## 5.5 LU Decomposition

Factorize:

$$A = LU$$

where $L$ is **lower triangular with unit diagonal** and $U$ is **upper triangular**.

$$A = \begin{pmatrix} 1 & 0 & 0 \\ m_{21} & 1 & 0 \\ m_{31} & m_{32} & 1 \end{pmatrix} \begin{pmatrix} u_{11} & u_{12} & u_{13} \\ 0 & u_{22} & u_{23} \\ 0 & 0 & u_{33} \end{pmatrix}$$

**Solving $Ax = B$ via LU:**

1. $Ly = B$ — solve by forward substitution
2. $Ux = y$ — solve by back substitution

**How to find $L$ and $U$:**

> **note:** *"U is the upper triangular result of the Gaussian elimination process. L is formed by the multipliers m_ij obtained during elimination; the main diagonal is unitary."*

**Why LU is advantageous:**

> **note:** *"The LU decomposition can be more advantageous because we work directly with the coefficient matrix A (not the augmented), and to generalize the solution to a new constant vector it suffices to swap the B vector in the first step of solving Ly = B."*

This means: factorize once ($O(n^3)$), then solve for any number of right-hand sides in $O(n^2)$ each.

### Determinant via LU

$$\det(A) = \det(L) \cdot \det(U) = 1 \cdot \prod_{i=1}^{n} u_{ii} = \prod_{i=1}^{n} u_{ii}$$

> **note:** *"The determinant of an upper triangular matrix is the product of its diagonal values. This is obtained almost for free."*

---

# 6. Iterative Methods

Produce an **approximate** solution via a sequence:

$$x^{(0)}, x^{(1)}, x^{(2)}, \ldots \longrightarrow x^*$$

starting from an initial guess $x^{(0)}$.

---

## 6.1 Jacobi Method

$$x_i^{(k+1)} = \frac{1}{a_{ii}} \left( b_i - \sum_{\substack{j=1 \\ j \neq i}}^{n} a_{ij} x_j^{(k)} \right)$$

> **note:** *"(Obeys the row criterion)"*

All updates in iteration $k+1$ use **only values from iteration $k$**. This means the entire old vector is used, and the new vector is computed simultaneously.

**Matrix form:** $x^{(k+1)} = D^{-1}(B - (L+U)x^{(k)})$, where $D$ is the diagonal of $A$.

---

## 6.2 Gauss-Seidel Method

$$x_i^{(k+1)} = \frac{1}{a_{ii}} \left( b_i - \sum_{j=1}^{i-1} a_{ij} x_j^{(k+1)} - \sum_{j=i+1}^{n} a_{ij} x_j^{(k)} \right)$$

> **note:** *"Takes advantage of the approximation made in the current step. Converges faster."*

As soon as a new $x_j^{(k+1)}$ is computed, it is **immediately used** in subsequent equations of the same iteration. This makes Gauss-Seidel generally converge about twice as fast as Jacobi.

---

## 6.3 Convergence Criterion — Row Criterion

For convergence of iterative methods, $A$ must be **strictly diagonally dominant**:

$$|a_{ii}| > \sum_{\substack{j=1 \\ j \neq i}}^{n} |a_{ij}| \quad \text{for every row } i$$

> **note:** *"For each row, if the absolute value on the main diagonal is greater than or equal to the sum of the absolute values of all other elements in the row. You can also reorder rows to satisfy the criterion."*

**Intuition:** Diagonal dominance ensures the "self-influence" of each variable is stronger than all cross-influences combined, preventing oscillation and guaranteeing convergence.

---

# 7. Polynomial Interpolation

> **note:** *"Approximation of functions whose mathematical form is unknown or difficult to compute, using a set of tabulated points/data. The discovered function is the interpolating polynomial."*

**Fundamental theorem:** Given $n+1$ distinct points $(x_0, f(x_0)), \ldots, (x_n, f(x_n))$, there exists **exactly one polynomial of degree $\leq n$** passing through all of them.

**Why unique?** The Vandermonde matrix (coefficient matrix for the polynomial system) has nonzero determinant whenever all $x_i$ are distinct, guaranteeing a unique solution.

> **note:** *"The matrix A of polynomial coefficients is called the Vandermonde matrix. Since no x_i (for equal degree) can be equal, the rows are linearly independent → det(A) ≠ 0 → unique polynomial!"*

**Basis for numerical integration.**

---

## 7.1 Via Linear Systems (Vandermonde)

The polynomial:

$$P_n(x) = a_0 + a_1 x + a_2 x^2 + \cdots + a_n x^n$$

For each given point $(x_i, f(x_i))$, one equation is formed. With $n+1$ points this gives an $(n+1) \times (n+1)$ linear system:

$$\begin{pmatrix} 1 & x_0 & x_0^2 & \cdots & x_0^n \\ 1 & x_1 & x_1^2 & \cdots & x_1^n \\ \vdots & & & & \vdots \\ 1 & x_n & x_n^2 & \cdots & x_n^n \end{pmatrix} \begin{pmatrix} a_0 \\ a_1 \\ \vdots \\ a_n \end{pmatrix} = \begin{pmatrix} f(x_0) \\ f(x_1) \\ \vdots \\ f(x_n) \end{pmatrix}$$

---

## 7.2 Lagrange Interpolation

$$P_n(x) = \sum_{i=0}^{n} f(x_i) L_i(x)$$

where the **Lagrange basis polynomials** are:

$$L_i(x) = \prod_{\substack{j=0 \\ j \neq i}}^{n} \frac{x - x_j}{x_i - x_j}$$

**Key property:** $L_i(x_i) = 1$ and $L_i(x_j) = 0$ for $j \neq i$, which guarantees interpolation.

> **note:** *"The problem with Lagrange form is that when a new point is added, the Lagrange basis (which depends on the number of points) must be recomputed."*

---

## 7.3 Newton Interpolation (Divided Differences)

**Divided differences** — recursive definition:

$$f[x_i] = f(x_i)$$

$$f[x_0, x_1] = \frac{f(x_1) - f(x_0)}{x_1 - x_0}$$

$$f[x_0, x_1, \ldots, x_n] = \frac{f[x_1, \ldots, x_n] - f[x_0, \ldots, x_{n-1}]}{x_n - x_0}$$

**Newton's interpolating polynomial:**

$$P_n(x) = f[x_0] + (x-x_0)f[x_0,x_1] + (x-x_0)(x-x_1)f[x_0,x_1,x_2] + \cdots$$

$$P_n(x) = \sum_{k=0}^{n} \left[ f[x_0,\ldots,x_k] \prod_{j=0}^{k-1}(x - x_j) \right]$$

> **note:** *"Having n points, to extend the approximating polynomial to n+1 points it suffices to add the residual term."*

**Advantage over Lagrange:** Adding a new point only requires computing **one new divided difference** and appending one term — no recomputation of previous terms.

---

# 8. Curve Fitting

Unlike interpolation (which passes through every point), curve fitting finds the **best-fit** function for a set of noisy data.

---

## 8.1 Least Squares (Linear Regression)

**Deviation function:**

$$d = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2$$

> **note:** *"Used to compare model error."*

**Goal:** Minimize $d$ over the model parameters.

For a linear model $\hat{y} = b_0 + b_1 x$, differentiate $d$ with respect to both $b_0$ and $b_1$ and set the derivatives to zero:

$$\frac{\partial d}{\partial b_0} = 0, \quad \frac{\partial d}{\partial b_1} = 0$$

This yields the **normal equations**:

$$b_1 = \frac{n\sum x_i y_i - \sum x_i \sum y_i}{n \sum x_i^2 - \left(\sum x_i\right)^2}$$

$$b_0 = \bar{y} - b_1 \bar{x}$$

where $\bar{x}$ and $\bar{y}$ are the sample means.

---

## 8.2 Coefficient of Determination

$$R^2 = 1 - \frac{\sum(y_i - \hat{y}_i)^2}{\sum(y_i - \bar{y})^2}$$

> **note:** *"The closer to 1, the better. Says how much the fitting variable corresponds to the result found."*

$R^2 = 1$ means a perfect fit; $R^2 = 0$ means the model explains none of the variance in the data.

---

# 9. Numerical Integration

**Goal:** Compute

$$\int_a^b f(x)\,dx$$

when $f$ has a difficult or unknown antiderivative.

> **note:** *"Approximate f through an interpolating polynomial. The integration over the polynomial interval will approximate the integral of the original function f."*

---

## 9.1 Newton-Cotes Closed Formulas

**Step size** for $n$ points:

$$h = \frac{b-a}{n}$$

**Node points:**

$$x_i = a + i \cdot h, \quad i = 0, 1, \ldots, n$$

> **note:** *"ATTENTION: points created from an increment of h are equidistant; if points are given as data, they MUST be equidistant."*

---

### Rectangle Rule (degree 0)

$$I \approx h \cdot f(a)$$

> **note:** *"Left approximation, considers f(a)."*

---

### Midpoint Rule (degree 0)

$$I \approx h \cdot f\!\left(\frac{a+b}{2}\right)$$

The rectangle height is evaluated at the midpoint instead of the endpoint, generally giving a better approximation.

---

### Trapezoidal Rule (degree 1)

$$I \approx \frac{h}{2}\big[f(x_0) + f(x_1)\big]$$

> **note:** *"To arrive at this equation we use Lagrange's method for the degree-1 interpolating polynomial before integrating. Like a trapezoid whose 'top' connects points a and b."*

**Error:** $O(h^2)$ per interval — the trapezoidal rule is exact for linear functions.

---

### Simpson's 1/3 Rule (degree 2)

Requires **three points**:

$$I \approx \frac{h}{3}\big[f(x_0) + 4f(x_1) + f(x_2)\big]$$

> **note:** *"To arrive at this, we use Lagrange's method for the degree-2 polynomial."*

**Error:** $O(h^4)$ — exact for polynomials up to degree 3 (surprisingly, one order higher than expected from a degree-2 polynomial).

---

### Simpson's 3/8 Rule (degree 3)

Requires **four points**:

$$I \approx \frac{3h}{8}\big[f(x_0) + 3f(x_1) + 3f(x_2) + f(x_3)\big]$$

> **note:** *"To arrive at this, we use Lagrange's method for the degree-3 polynomial."*

---

## 9.2 Composite Newton-Cotes

> **note:** *"It is not convenient to increase the polynomial degree; instead, break the original domain into segments/subintervals and apply the closed formulas repeatedly."*

Divide $[a,b]$ into $m$ equal subintervals:

$$h = \frac{b-a}{m}$$

$$\int_a^b f(x)\,dx = \sum_{i=1}^{m} \int_{x_{i-1}}^{x_i} f(x)\,dx$$

### Composite Rectangle Rule

$$I \approx \sum_{i=1}^{m} h \cdot f(x_{i-1})$$

### Composite Midpoint Rule

$$I \approx \sum_{i=1}^{m} h \cdot f\!\left(\frac{x_{i-1}+x_i}{2}\right)$$

### Composite Trapezoidal Rule

$$I \approx \frac{h}{2} \sum_{i=0}^{m} c_i f(x_i)$$

with **Cotes weights**:

$$c_0 = c_m = 1, \qquad c_i = 2 \text{ for } i \in [1, m-1]$$

Which expands to:

$$I \approx \frac{h}{2}\left[f(x_0) + 2\sum_{i=1}^{m-1}f(x_i) + f(x_m)\right]$$

> **note:** *"c_i are the Cotes weights (values that multiply the f(x_i) functions)."*

---

## 9.3 Gauss-Legendre Quadrature

> **note:** *"Does not depend on equidistant or fixed points. Freedom to choose points allows balancing sub- and over-estimation errors, more faithful to the exact value. Uses the method of undetermined coefficients from Calculus IV."*

General form over $[-1, 1]$:

$$\int_{-1}^{1} f(x)\,dx \approx \sum_{i=1}^{n} c_i f(x_i)$$

The nodes $x_i$ and weights $c_i$ are chosen to **maximize the degree of polynomials integrated exactly**.

### 2-Point Rule

Applying exactness conditions for polynomials up to degree 3 yields:

$$c_0 = c_1 = 1, \quad x_0 = -\frac{1}{\sqrt{3}}, \quad x_1 = +\frac{1}{\sqrt{3}}$$

$$\int_{-1}^{1} f(x)\,dx \approx f\!\left(-\frac{1}{\sqrt{3}}\right) + f\!\left(\frac{1}{\sqrt{3}}\right)$$

> **note:** *"Any integral from -1 to 1 satisfying the constraints has its exact result given by I."*

**For more points:** A 3-point rule is exact for polynomials of degree 4 and 5. In general, an $n$-point Gauss-Legendre rule is exact for polynomials of degree up to $2n-1$.

**Important requirement:**

> **note:** *"Knowledge of the function definition is required, and it must be evaluated at specific points to balance the result. Experimental scattered data does not come from a mathematical form, so the function must be known."*

This distinguishes Gauss quadrature from Newton-Cotes: **it requires the ability to evaluate $f$ at arbitrary points**.

---
