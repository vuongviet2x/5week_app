
&AtClient
Procedure ProductsProductOnChange(Item)
	// Getting current tabular section row
	TabularSectionRow = Items.Products.CurrentData;

	// Setting price
	TabularSectionRow.Price = DocumentProcessing.RetailPrice(Object.Date,TabularSectionRow.Product);
EndProcedure
