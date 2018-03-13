#!/bin/bash
# ==============================================================================
# Autorské práva (c) 2018 Juraj 'hvge' Ďurech
# 
# Licencia pod Licenciou Apache verzie 2.0 ("Licencia");
# nesmiete používať tento súbor okrem prípadov, keď je to v súlade s Licenciou.
# Kópiu licencie môžete získať na adrese
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Ak to nevyžaduje príslušný zákon alebo písomne súhlasí, softvér
# distribuovaný pod licenciou je distribuovaný na základe "ako je",
# BEZ ZÁRUK ALEBO PODMIENOK AKÉHOKOĽVEK DRUHU, či už výslovne alebo implicitne.
# Pozrite si Licenciu pre konkrétny jazyk, ktorý upravuje povolenia a
# obmedzenia v rámci licencie.
# ==============================================================================

set -e
set +v

HORE=$(dirname $0)
HORE="`( cd \"$HORE\" && pwd )`"
if [ -z "$HORE" ]; then
    echo "Zheblo to."
	exit 1
fi

#### 

CITAJ="$HORE/../README.md"
panSABLONI="$HORE/sabloni.md"

function utec
{
	echo "$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1")"
}

function davajPolitruka
{
	local vseckiMudrosti=""
	local cestaPolitruka="$1"

	while read -r riadko
	do
		if [ "$vseckiMudrosti" != "" ]; then
			vseckiMudrosti+="%0D%0A"
		fi
		vseckiMudrosti+=$(utec "$riadko")
	done < "$cestaPolitruka"

	echo $vseckiMudrosti
}

function davajParaemtre
{
	local politruk="$1"
	local zvomlanie=$(utec "$2")
	local zomlik=$(utec "$3")
	local mudrosci="$4"
	local nazov=$(utec "$politruk Bingo")
	
	echo "\?title=${nazov}\&exclamation=${zvomlanie}\&free_square=${zomlik}\&terms=${mudrosci}"
}

echo "#### nahravam sampionov..."

# fico
ficove_mudrosti=$(davajPolitruka "${HORE}/politruci/ficove.txt")
ficovo_bingo=$(davajParaemtre 'Fico' 'Slovenskóoóóó!!' 'SOROS' $ficove_mudrosti)


echo "#### skladam ucty..."

sed -e "s/FINGO/${ficovo_bingo}/g" "${panSABLONI}" > "${CITAJ}"

sleep 1
echo "#### pumblikujem vysledky..."

git add "${CITAJ}"
git commit -m "Za Lempsie zajtrajsky"

sleep 2
echo "#### vsetko v cajku"
