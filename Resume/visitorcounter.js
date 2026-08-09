const api = "https://gwgcmdxf1f.execute-api.eu-west-2.amazonaws.com/counter-stage/visitors"

async function updateCounter() {
    const response = await fetch(api,{
        method: "POST"
    });
    const data = await response.json();

    document.getElementById("visitor-count").textContent = data.count;
}

updateCounter();