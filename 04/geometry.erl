-module(geometry).
-export([area/1, perimiter/1, semiperimiter/1, test_area/0, test_perimiter/0]).

test_area() ->
    32.0 = area({rectangle, 3.2, 10}),
    9 = area({square, 3}),
    2*3.14156 = area({ellipse, 1, 2}),
    3*3*3.14156 = area({circle, 3}),
    1.0 = area({right_triangle, 1, 2}),
    6.0 = area({triangle, 3, 4, 5}),
    area_tests_passed.

test_perimiter() ->
    12 = perimiter({rectangle, 2, 4}),
    16 = perimiter({square, 4}),
    3.14156 = perimiter({circle, 0.5}),
    12 = perimiter({triangle, 3, 4, 5}),
    perimiter_tests_passed.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side;
area({ellipse, Semimajor, Semiminor}) -> 3.14156 * Semimajor * Semiminor;
area({circle, Radius}) -> area({ellipse, Radius, Radius});
area({right_triangle, Side1, Side2}) -> Side1 * Side2 * 0.5;
area({triangle, A, B, C}) -> % Heron's formula
    math:sqrt(4*A*A*B*B - math:pow(A*A + B*B - C*C, 2)) * 0.25. 

perimiter({rectangle, Width, Height}) -> 2 * (Width + Height);
perimiter({square, Side}) -> Side * Side;
perimiter({circle, Radius}) -> 3.14156 * Radius * 2;
perimiter({ellipse, Semimajor, Semiminor}) -> % Ramanujan approximation
    3.14156 * (Semimajor + Semiminor) * (1 + 3*h(Semimajor, Semiminor)/(10 + math:sqrt(4 - 3*h(Semimajor, Semiminor))));
perimiter({triangle, Side1, Side2, Side3}) -> Side1 + Side2 + Side3.

semiperimiter(Shape) ->
    0.5 * perimiter(Shape).

h(A, B) ->
    math:pow(A - B, 2)/math:pow(A + B, 2).
