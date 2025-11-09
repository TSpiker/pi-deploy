# =====================================================
# Raspberry Pi Deployment Makefile
# =====================================================

.PHONY: setup update pull clean

setup:
	@echo "🚀 Running full Pi setup..."
	sudo bash setup_pi.sh

update:
	@echo "🔄 Pulling latest repo changes..."
	sudo git -C /opt/pi-deploy pull

pull:
	@echo "📦 Pulling repo and updating Python dependencies..."
	sudo git -C /opt/pi-deploy pull
	sudo -u pi /opt/scripts/venv/bin/pip install -r /opt/pi-deploy/requirements.txt

clean:
	@echo "🧹 Cleaning up logs..."
	sudo rm -f /var/log/setup_pi.log
