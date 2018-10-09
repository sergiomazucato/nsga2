function mutation = mut(x , tcromossomo)
    %
    %
    
    %%
    y = round((tcromossomo - 1) * rand) + 1;
    
    x(y) = round(rand - rand) + x(y);
    
    mutation = x;
    
    return;    
end