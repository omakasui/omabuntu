# Controlla che il branch corrente di omakub sia il dev, se lo è allora aggiorna i riferimenti alla repository apt
if [[ "$(omakub-version-branch)" == "dev" ]]; then
    echo "Updating APT repository references for dev branch..."
    omakub-refresh-apt "dev"
fi