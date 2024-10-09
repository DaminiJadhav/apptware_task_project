import 'package:flutter/material.dart';

/*class CustomPaginatedDataTableExample extends StatefulWidget {
  @override
  _CustomPaginatedDataTableExampleState createState() => _CustomPaginatedDataTableExampleState();
}

class _CustomPaginatedDataTableExampleState extends State<CustomPaginatedDataTableExample> {
  int _rowsPerPage = 10; // Set this to a high number to disable pagination
  int _currentPage = 0;
  int _totalRows = 100; // Example total row count; replace with actual row count

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Pagination UI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PaginatedDataTable(
              showCheckboxColumn: false,
              showFirstLastButtons: false,
              header: Text('Table Header'),
              columns: _getColumns(),
              source: _MyDataSource(), // Replace with your DataSource
              rowsPerPage: _rowsPerPage, // Set rows per page to a high number
              availableRowsPerPage: [_rowsPerPage], // To avoid rows per page dropdown
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value! ;
                });
              },
              onPageChanged: (pageIndex) {
                setState(() {
                  _currentPage = pageIndex;
                });
              },
            ),
          ),
          _buildCustomPaginationControls(),
        ],
      ),
    );
  }

  List<DataColumn> _getColumns() {
    return [
      DataColumn(label: Text('Column 1')),
      DataColumn(label: Text('Column 2')),
      // Add more columns as needed
    ];
  }

  Widget _buildCustomPaginationControls() {
    int totalPages = (_totalRows / _rowsPerPage).ceil();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Rows per page:'),
          DropdownButton<int>(
            value: _rowsPerPage,
            items: [10, 20, 50, 100].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _rowsPerPage = newValue!;
              });
            },
          ),
          Spacer(),
          Text('Page ${_currentPage + 1} of $totalPages'),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _currentPage > 0
                ? () {
              setState(() {
                _currentPage--;
              });
            }
                : null,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: _currentPage < totalPages - 1
                ? () {
              setState(() {
                _currentPage++;
              });
            }
                : null,
          ),
        ],
      ),
    );
  }
}

class _MyDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    // Return DataRow based on the index
    return DataRow(cells: [
      DataCell(Text('Row $index Col 1')),
      DataCell(Text('Row $index Col 2')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100; // Replace with actual row count

  @override
  int get selectedRowCount => 0;
}*/

class CustomPaginationTable extends StatefulWidget {
  @override
  _CustomPaginationTableState createState() => _CustomPaginationTableState();
}

class _CustomPaginationTableState extends State<CustomPaginationTable> {
  int _rowsPerPage = 5; // Rows per page
  int _currentPage = 0; // Current page
  final int _totalRows = 20; // Total number of rows in the table

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Paginated DataTable'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PaginatedDataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Age')),
              ],
              source: MyDataSource(),
              rowsPerPage: _rowsPerPage, // Rows displayed per page
              showFirstLastButtons: false, // Hide the default first/last buttons
              availableRowsPerPage: [], // Hide rows-per-page dropdown
              onRowsPerPageChanged: null, // Disable default pagination
            ),
          ),
          // Custom Pagination Bar
          Container(
            height: 40, // Set a custom height
            padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rows per page:'),
                DropdownButton<int>(
                  value: _rowsPerPage,
                  onChanged: (value) {
                    setState(() {
                      _rowsPerPage = value!;
                      _currentPage = 0; // Reset to first page on row change
                    });
                  },
                  items: [5, 10, 15, 20].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value'),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: _currentPage > 0
                          ? () {
                        setState(() {
                          _currentPage--;
                        });
                      }
                          : null,
                    ),
                    Text('${_currentPage + 1} of ${(_totalRows / _rowsPerPage).ceil()}'),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: (_currentPage + 1) * _rowsPerPage < _totalRows
                          ? () {
                        setState(() {
                          _currentPage++;
                        });
                      }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('John Doe')),
      DataCell(Text('25')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}