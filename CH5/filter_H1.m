function [ output ] = filter_H1( M, N, k, o )
    u = [1:M]-M/2 ;
    v = [1:N]-N/2 ;
    [V, U] = meshgrid(v,u);
    D = (V.^2+U.^2).^o;
    output = exp(-k.*D);
end