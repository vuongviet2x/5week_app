
&AtClient
Procedure ProductsProductOnChange(Item)
	// Insert handler content.                 
//	DòngHiệnTại= Items.Products.CurrentData;  
//	DòngHiệnTại.ĐơnVịTính = FillUnit(DòngHiệnTại.Product);
	TabularSectionRow = Items.Products.CurrentData;  
	TabularSectionRow.Unit = FillUnit(TabularSectionRow.Product);
EndProcedure

&AtServer
Function FillUnit ( CurProduct )
	Return CurProduct.Unit;
EndFunction

&AtClient
Procedure ProductsQuantityOnChange(Item)
	// Insert handler content. 
	//DòngHiệnTại= Items.Products.CurrentData;
	//CalculateAmount(DòngHiệnTại);   
	TabularSectionRow = Items.Products.CurrentData;
	CalculateAmount(TabularSectionRow);
EndProcedure           


&AtClient
Procedure ProductsPriceOnChange(Item)
	// Insert handler content.     
	//DòngHiệnTại= Items.Products.CurrentData;
	//CalculateAmount(DòngHiệnTại);  
	TabularSectionRow = Items.Products.CurrentData;
	CalculateAmount(TabularSectionRow);
	
EndProcedure    

&AtClient
Procedure CalculateAmount(CurRow)
	CurRow.Amount = CurRow.Quantity * CurRow.Price;
	Object.Total = Object.Products.Total("Amount");
EndProcedure


&AtServer
Procedure PaymentMethodOnChangeAtServer()
	If Object.PaymentMethod = Enums.PaymentMethods.Cash Then
		 ThisObject.CommandBar.ChildItems.FormCreateBasedOn.Visible = False;
	 Else
		ThisObject.CommandBar.ChildItems.FormCreateBasedOn.Visible = True; 
	EndIf
EndProcedure


&AtClient
Procedure PaymentMethodOnChange(Item)
	PaymentMethodOnChangeAtServer();
EndProcedure

