function [ output ] = wiener_filter1( k, F, H)
% WIENER_FILTER generates a typical Wiener filter by definition
    H2 = abs(H) .^ 2;
    output = (1./H).*(H2./(H2+k));
end