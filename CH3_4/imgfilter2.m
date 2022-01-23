function [ g ] = imgfilter2( w, x ,p)
    [h_x, w_x] = size(x);
    g = zeros(h_x, w_x);
    D = padarray(x,[p p],0,'both');
    for i = p+1 : h_x
        for j = p+1 : w_x
            g(i,j) = sum(w.*D(i-p:i+p,j-p:j+p),'All');
        end
    end
end