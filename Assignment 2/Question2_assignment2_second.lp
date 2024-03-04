%now based on our actual input
container(4, 6).
item(1, 1, 3).
item(2, 2, 2).  
item(3, 2, 3).
item(4, 3, 3).

%generate all valid X positions for an item within the container dynamically
valid_x(ItemID, X) :-
    item(ItemID, _, Width),
    container(_, ContainerWidth),
    X = 0..ContainerWidth-Width.

%generate all valid Y positions for an item within the container
valid_y(ItemID, Y) :-
    item(ItemID, Height, _),
    container(ContainerHeight, _),
    Y = 0..ContainerHeight-Height.

%place an item at any valid position only if it at a valid position
1 { placed(ItemID, X, Y) : valid_x(ItemID, X), valid_y(ItemID, Y) } 1 :-
    item(ItemID, _, _).

%Prevent the overlap between items
:- placed(I1, X1, Y1), placed(I2, X2, Y2),
   item(I1, H1, W1), item(I2, H2, W2),
   I1 != I2,
   X1 < X2 + W2, X2 < X1 + W1, Y1 < Y2 + H2, Y2 < Y1 + H1.

%display the placement of all items bottom left corner
#show placed/3.
