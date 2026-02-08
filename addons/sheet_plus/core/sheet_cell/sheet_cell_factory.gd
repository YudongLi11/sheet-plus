class_name SheetCellFactory


const TEXT_SHEET_CELL = preload("uid://3dipo7cpmkmo")
const NUMBER_SHEET_CELL = preload("uid://b7pa4pgpvifai")
const CURRENCY_SHEET_CELL = preload("uid://dgkw4adr7bhcx")
const PERCENTAGE_SHEET_CELL = preload("uid://bb65q572lly2t")
const DATE_SHEET_CELL = preload("uid://c1ts3afp63620")
const BOOLEAN_SHEET_CELL = preload("uid://mc55jjsc2egq")
const PROGRESS_SHEET_CELL = preload("uid://bx557lgmt1erx")


static func create_sheet_cell(type: SheetGlobals.CellType) -> SheetCell:
	match type:
		SheetGlobals.CellType.TEXT:
			var cell: SheetCell = TEXT_SHEET_CELL.instantiate()
			return cell
		SheetGlobals.CellType.NUMBER:
			var cell: SheetCell = NUMBER_SHEET_CELL.instantiate()
			return cell
		SheetGlobals.CellType.CURRENCY:
			var cell: SheetCell = CURRENCY_SHEET_CELL.instantiate()
			return cell
		SheetGlobals.CellType.PERCENTAGE:
			var cell: SheetCell = PERCENTAGE_SHEET_CELL.instantiate()
			return cell
		SheetGlobals.CellType.DATE:
			var cell: SheetCell = DATE_SHEET_CELL.instantiate()
			return cell
		SheetGlobals.CellType.BOOLEAN:
			var cell: SheetCell = BOOLEAN_SHEET_CELL.instantiate()
			return cell
		SheetGlobals.CellType.PROGRESS:
			var cell: SheetCell = PROGRESS_SHEET_CELL.instantiate()
			return cell
		_:
			var cell: SheetCell = TEXT_SHEET_CELL.instantiate()
			return cell
