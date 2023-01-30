import {Controller} from "@hotwired/stimulus";

export default class extends Controller {

    addRow() {
        console.log('Add')
        let tableRef = document.getElementById("construction-table")
                               .getElementsByTagName('tbody')[0]
        console.log(tableRef)
        let new_id = tableRef.rows.length
        tableRef.insertRow(new_id)
        for (let i = 0; i < tableRef.rows[0].cells.length; i++) {
            let cell = tableRef.rows[new_id].insertCell()
            if (i === 0) {
                cell.innerHTML = (new_id + 1).toString()
            } else {
                cell
            }
        }
    }

    deleteRow() {
        console.log('Delete')
        let tableRef = document.getElementById("construction-table")
                               .getElementsByTagName('tbody')[0]
        tableRef.deleteRow(tableRef.rows.length - 1)
    }
}
