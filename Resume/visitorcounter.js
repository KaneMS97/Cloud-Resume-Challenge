let count = 0
const api = "https://gwgcmdxf1f.execute-api.eu-west-2.amazonaws.com"

async function updateCounter() {
    const response = await fetch(api);
    const data = await response.json();

    document.getElementById("visitor-count").textContent = data.count;
}

updateCounter();