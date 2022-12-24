import { Controller } from "@hotwired/stimulus";
import Highcharts from "highcharts"

export default class extends Controller {
    connect() {
        const tableBodies = document.getElementById("construction-table")
                                    .getElementsByClassName("card-body")

        let m = {}
        let u = {}
        let s = {}
        for ( let i = 0; i < tableBodies.length; i++ ) {
            console.log(tableBodies[i])
        }

        Highcharts.chart('container', {
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Fruit Consumption'
            },
            xAxis: {
                categories: ['Apples', 'Bananas', 'Oranges']
            },
            yAxis: {
                title: {
                    text: 'Fruit eaten'
                }
            },
            series: [{
                name: 'Jane',
                data: [1, 0, 4]
            }, {
                name: 'John',
                data: [5, 7, 3]
            }]
        })
    }
}