import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "constructRow", "title", "supportLeft", "supportRight" ]
    static values = {
        id: String
    }

    addRow() {
        console.log('Add')
        let tableRef = document.getElementById("construction-table")
            .getElementsByTagName('tbody')[0]
        let new_id = tableRef.rows.length
        tableRef.insertRow(new_id)
        for (let i = 0; i < tableRef.rows[0].cells.length; i++) {
            let cell = tableRef.rows[new_id].insertCell()
            if (i === 0) {
                cell.innerHTML = (new_id + 1).toString()
            } else {
                cell.dataset.action = 'click->new-construction-table#editCell'
                cell.innerHTML = '0'
            }
        }
    }

    deleteRow() {
        console.log('Delete')
        let tableRef = document.getElementById("construction-table")
            .getElementsByTagName('tbody')[0]
        tableRef.deleteRow(tableRef.rows.length - 1)
    }

    editTitle(e) {
        console.log("editTitle")
        e.preventDefault()
        let constrTitle = e.target
        constrTitle.contentEditable = true
    }

    editCell(e) {
        console.log('editCell')
        e.preventDefault()
        let cell = e.target
        cell.contentEditable = true
    }

    async saveEdited() {
        console.log('saveEdited')
        const supportLeft = document.getElementById("support-left").checked
        const supportRight = document.getElementById("support-right").checked
        let constructionTitle = document.getElementById("construction-title")
        let constructionTable = document.getElementById("construction-table")
                                        .getElementsByTagName('tbody')[0]
        let rows = constructionTable.getElementsByTagName('tr')

        let rods = []
        for (let i = 0; i < rows.length; i++) {
            let cells = rows[i].getElementsByTagName('td')
            let rod = {
                place_id: cells[0].textContent,
                l: cells[1].textContent,
                a: cells[2].textContent,
                e: cells[3].textContent,
                b: cells[4].textContent,
                f: cells[5].textContent,
                q: cells[6].textContent
            }
            rods.push(rod)
        }

        const formData = new FormData()
        formData.append('construction[name]', constructionTitle.textContent.trim())
        formData.append('construction[left_support]', supportLeft)
        formData.append('construction[right_support]', supportRight)
        formData.append('construction[rods]', JSON.stringify(rods))

        await this.doPatch(`/preprocessor`, formData)
    }

    async doPatch(url, body) {
        const csrfToken = document.getElementsByName('csrf-token')[0].content
        const response = await fetch(url, {
            method: 'POST',
            body: body,
            headers: {
                "X-CSRF-Token": csrfToken
            }
        })

        if(!response.ok) {
            console.log("Failed")
        }
    }
}
