% Container and item definitions (dynamic input)
container(4, 6).
item(1, 1, 3).
item(2, 2, 2).
item(3, 2, 3).
item(4, 3, 3).

% Helper predicate to generate numbers from 0 up to Max.
% Generate numbers up to the container's height
number_h(0).
number_h(Y+1) :- number_h(Y), container(H, _), Y+1 < H.

% Generate numbers up to the container's width
number_w(0).
number_w(X+1) :- number_w(X), container(_, W), X+1 < W.

% Generate valid positions for each item considering container dimensions.
valid_position(ItemID, X, Y) :-
    item(ItemID, Height, Width),
    container(ContainerHeight, ContainerWidth),
    number_w(X), number_h(Y),
    X + Width <= ContainerWidth,
    Y + Height <= ContainerHeight.

% Choose to place each item at one of the valid positions.
1 { placed(ItemID, X, Y) : valid_position(ItemID, X, Y) } 1 :- item(ItemID, _, _).

% Ensure items do not overlap.
:- placed(I1, X1, Y1), placed(I2, X2, Y2),
   item(I1, H1, W1), item(I2, H2, W2),
   I1 != I2,
   X1 < X2 + W2, X2 < X1 + W1, Y1 < Y2 + H2, Y2 < Y1 + H1.

% Display the placement of items
#show placed/3.