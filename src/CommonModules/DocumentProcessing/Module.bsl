Function RetailPrice(EffectiveDate, Product) Export
    //Creating auxiliary Filter object
    Filter = New Structure("Product", Product); 

    //Getting effective register resource value
    ResourceValues = InformationRegisters.PriceHistory.GetLast(EffectiveDate, Filter);
    Return ResourceValues.Price;
EndFunction