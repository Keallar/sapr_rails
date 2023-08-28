import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    draw() {
        let constructionTable = document.getElementById("construction-table")
            .getElementsByTagName('tbody')[0]
        let rows = constructionTable.getElementsByTagName('tr')
        let rods = []
        for (let i = 0; i < rows.length; i++) {
            let cells = rows[i].getElementsByTagName('td')
            let rod = {
                place_id: cells[0].textContent,
                L: cells[1].textContent,
                A: cells[2].textContent,
                E: cells[3].textContent,
                B: cells[4].textContent,
                F: cells[5].textContent,
                Q: cells[6].textContent
            }
            rods.push(rod)
        }
        const leftSupport = document.getElementById("support-left").checked
        const rightSupport = document.getElementById("support-right").checked

        let canvas = document.getElementById("visualizer");
        canvas.width = 1100;
        canvas.height = 600;
        let context = canvas.getContext('2d');
        context.clearRect(0, 0, context.canvas.width, context.canvas.height);

        if (canvas.getContext) {
            context.clearRect(0, 0, context.canvas.width, context.canvas.height);
            let X = 50;
            let Y = 50;
            let startX = X + 20;
            let currentWidth = 0;
            let currentHeight = 0;
            let widthFirst = 1000;
            let heightFirst = 100;
            let totalL = 0;
            let totalA = 0;
            let maxHeight = 0;
            let widthF = 20;
            let heightF = 70;
            let supportLeft = document.getElementById('supportLeft');
            let supportRight = document.getElementById('supportRight');
            let arrowLeft = document.getElementById('arrowLeft');
            let arrowRight = document.getElementById('arrowRight');
            let arrowLongLeft = document.getElementById('arrowLongLeft');
            let arrowLongRight = document.getElementById('arrowLongRight');

            for (let i = 0; i < rods.length; i++) {
                totalL += parseInt(rods[i].L);
            }

            for (let i = 0; i < rods.length; i++) {
                if (totalA < rods[i].A) {
                    totalA = rods[i].A
                }
            }

            let coefL = (widthFirst - 40) / totalL;
            let coefA = (heightFirst - 40) / totalA;

            for (let i = 0; i < rods.length; i++) {
                currentWidth = rods[i].L * coefL;
                currentHeight = rods[i].A * coefA;

                if (currentHeight > maxHeight) {
                    maxHeight = currentHeight;
                }

                if (!rods[i].L || !rods[i].L) {
                    if (i != rods.length - 1) {
                        alert('Error! ');
                        return;
                    }
                } else {
                    let xFirst = 50;
                    let yFirst = 50;
                    X = widthFirst;
                    let xQ = startX;
                    let widthQ = 30;
                    let heightQ = 15;

                    context.strokeRect(
                        startX,
                        yFirst + heightFirst / 2 - currentHeight / 2,
                        currentWidth,
                        currentHeight
                    );

                    startX += currentWidth;

                    if (rods[i].F > 0) {
                        context.drawImage(
                            arrowLongRight,
                            xQ,
                            yFirst + heightFirst / 2 - currentHeight / 3 / 2,
                            currentWidth / 2,
                            currentHeight / 3
                        );
                    } else if (rods[i].F < 0 && i > 0) {
                        context.drawImage(
                            arrowLongLeft,
                            xQ - (rods[i - 1].L * coefL) / 2,
                            yFirst + heightFirst / 2 - (rods[i - 1].A * coefA) / 3 / 2,
                            (rods[i - 1].L * coefL) / 2,
                            (rods[i - 1].A * coefA) / 3
                        );
                    }

                    if (rods[i].Q > 0) {
                        do {
                            context.drawImage(
                                arrowRight,
                                xQ,
                                yFirst + heightFirst / 2 - heightQ / 2,
                                widthQ,
                                heightQ
                            )
                            xQ += widthQ;
                        } while (xQ + widthQ <= startX);
                    } else if (rods[i].Q < 0) {
                        do {
                            context.drawImage(
                                arrowLeft,
                                xQ,
                                yFirst + heightFirst / 2 - heightQ / 2,
                                widthQ,
                                heightQ
                            )
                            xQ += widthQ;
                        } while (xQ + widthQ <= startX);
                    }

                    let endFirst = widthFirst + 30;

                    if (leftSupport) {
                        context.drawImage(
                            supportLeft,
                            xFirst,
                            yFirst + heightFirst / 2 - heightF / 2,
                            widthF,
                            heightF
                        );
                    }

                    if (rightSupport) {
                        context.drawImage(
                            supportRight,
                            endFirst,
                            yFirst + heightFirst / 2 - heightF / 2,
                            widthF,
                            heightF
                        );
                    }
                }
            }
        }
    }
}