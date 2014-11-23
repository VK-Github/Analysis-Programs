function Val = GrabmyData(inVal)
    %figure;imshow(inVal)
    currfig = gcf;
    choice = menu('Would you like to continue analysis with this image?','Yes','No')
    if choice == 1
        sprintf('%s','Yay you like it :), Passing to PDAC')
        Val = inVal;
        PDAC_Data(Val);
    elseif choice == 2
        sprintf('%s','Its ok if you dont like it. We can try again')
        Val = inVal;
        close currfig
    end
end
