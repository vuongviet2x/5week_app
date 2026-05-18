
&AtClient
Procedure ProductsProductOnChange(Item)
	// Insert handler content.    
	TabularSectionRow = Items.Products.CurrentData ;
	TabularSectionRow.Unit = FillUnit(TabularSectionRow.Product);
	
	RemainingQuantity = RemainingQuantityInWarehouse(Object.Date, Object.WarehouseSender,TabularSectionRow.Product);	
	If RemainingQuantity = "" Then
		 ThisObject.RemainingQuantity = 0;
	Else
		ThisObject.RemainingQuantity = RemainingQuantity;
	EndIf;
	ThisObject.Product =  TabularSectionRow.Product;
EndProcedure                                   

&AtServer
Function FillUnit (CurMatHang)
	Return CurMatHang.Unit ;
EndFunction

&AtServer

Function RemainingQuantityInWarehouse(Date, Warehouse,Product)
	  	//{{QUERY_BUILDER_WITH_RESULT_PROCESSING
	// This fragment was built by the wizard.
	// Warning! All manually made changes will be lost next time you use the wizard.
	
	Query = New Query;
	Query.Text = 
		"SELECT
		|	InventoryBalance.Product AS Product,
		|	ISNULL(InventoryBalance.QuantityBalance, 0) AS QuantityBalance
		|FROM
		|	AccumulationRegister.Inventory.Balance(&Date, ) AS InventoryBalance
		|WHERE
		|	InventoryBalance.Product = &Product
		|	AND InventoryBalance.Warehouse = &Warehouse";  
	
	Query.SetParameter("Product", Product);
	Query.SetParameter("Warehouse", Warehouse);  
	Query.SetParameter("Date", Date);
	
	QueryResult = Query.Execute();
	
	SelectionDetailRecords = QueryResult.Select();
	
	While SelectionDetailRecords.Next() Do
		Return SelectionDetailRecords.QuantityBalance
	EndDo;
	
	//}}QUERY_BUILDER_WITH_RESULT_PROCESSING

EndFunction

&AtClient
Procedure WarehouseSenderOnChange(Item)        
	
	TabularSectionRow = Items.Products.CurrentData ;
   	If ValueIsFilled(Object.Products) Then
		RemainingQuantity = RemainingQuantityInWarehouse(Object.Date, Object.WarehouseSender,TabularSectionRow.Product);	
		If RemainingQuantity = "" Then
			 ThisObject.RemainingQuantity = 0;
		Else
			ThisObject.RemainingQuantity = RemainingQuantity;
		EndIf; 
   	EndIf;
EndProcedure
