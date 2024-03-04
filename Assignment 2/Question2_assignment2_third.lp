%based on our actual input
container(4, 6).
item(1, 1, 3).
item(2, 2, 2).
item(3, 2, 3).
item(4, 3, 3).

%dynamic valid X and Y positions based on container dimensions and item dims
1 { placed(ItemID, X, Y) : item(ItemID, Height, Width), X=0..ContainerWidth-Width, Y=0..ContainerHeight-Height } 1 :-
    item(ItemID, Height, Width),
    container(ContainerHeight, ContainerWidth).

%Prevent the overlap between items
:- placed(I1, X1, Y1), placed(I2, X2, Y2),
   item(I1, H1, W1), item(I2, H2, W2),
   I1 != I2,
   X1 < X2 + W2, X2 < X1 + W1, Y1 < Y2 + H2, Y2 < Y1 + H1.

%display the placement of all items bottom left corner
#show placed/3.