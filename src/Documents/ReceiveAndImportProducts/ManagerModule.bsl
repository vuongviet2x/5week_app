
Procedure InPhiếuNhậpKho(Spreadsheet, Ref) Export
	//{{_PRINT_WIZARD(InPhiếuNhậpKho)
	Template = Documents.ReceiveAndImportProducts.GetTemplate("PrintImportProducts");
	Query = New Query;
	Query.Text =
	"SELECT
	|	ReceiveAndImportProducts.Date AS Date,
	|	ReceiveAndImportProducts.Warehouse AS Warehouse,
	|	ReceiveAndImportProducts.Counterparty AS Counterparty,
	|	ReceiveAndImportProducts.Number AS Number,
	|	ReceiveAndImportProducts.Staff AS Staff,
	|	ReceiveAndImportProducts.Total AS Total,
	|	ReceiveAndImportProducts.Products.(
	|		LineNumber AS LineNumber,
	|		Product AS Product,
	|		Unit AS Unit,
	|		Quantity AS Quantity,
	|		Price AS Price,
	|		Amount AS Amount
	|	) AS Products
	|FROM
	|	Document.ReceiveAndImportProducts AS ReceiveAndImportProducts
	|WHERE
	|	ReceiveAndImportProducts.Ref IN(&Ref)";
	Query.Parameters.Insert("Ref", Ref);
	Selection = Query.Execute().Select();

	AreaCaption = Template.GetArea("Caption");
	Header = Template.GetArea("Header");
	AreaBảngMặtHàngHeader = Template.GetArea("BảngMặtHàngHeader");
	AreaBảngMặtHàng = Template.GetArea("BảngMặtHàng");
	Footer = Template.GetArea("Footer");

	Spreadsheet.Clear();

	InsertPageBreak = False;
	While Selection.Next() Do
		If InsertPageBreak Then
			Spreadsheet.PutHorizontalPageBreak();
		EndIf;

		Spreadsheet.Put(AreaCaption);

		Header.Parameters.Fill(Selection);
		Spreadsheet.Put(Header, Selection.Level());

		Spreadsheet.Put(AreaBảngMặtHàngHeader);
		SelectionBảngMặtHàng = Selection.BảngMặtHàng.Select();
		While SelectionBảngMặtHàng.Next() Do
			AreaBảngMặtHàng.Parameters.Fill(SelectionBảngMặtHàng);
			Spreadsheet.Put(AreaBảngMặtHàng, SelectionBảngMặtHàng.Level());
		EndDo;

		Footer.Parameters.Fill(Selection);
		Spreadsheet.Put(Footer);

		InsertPageBreak = True;
	EndDo;
	//}}
EndProcedure
