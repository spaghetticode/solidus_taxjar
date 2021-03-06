require 'spec_helper'

RSpec.describe SuperGood::SolidusTaxJar::API do
  describe "#tax_for" do
    subject { api.tax_for order }

    let(:api) { described_class.new(taxjar_client: dummy_client) }
    let(:dummy_client) { instance_double ::Taxjar::Client }
    let(:order) { Spree::Order.new }

    before do
      allow(SuperGood::SolidusTaxJar::APIParams)
        .to receive(:order_params)
        .with(order)
        .and_return({ order: "params" })

      allow(dummy_client)
        .to receive(:tax_for_order)
        .with({ order: "params" })
        .and_return({ some_kind_of: "response" })
    end

    it { is_expected.to eq({ some_kind_of: "response" }) }
  end

  describe "#tax_rates_for" do
    subject { api.tax_rates_for address }

    let(:api) { described_class.new(taxjar_client: dummy_client) }
    let(:dummy_client) { instance_double ::Taxjar::Client }
    let(:address) { Spree::Address.new }

    before do
      allow(SuperGood::SolidusTaxJar::APIParams)
        .to receive(:address_params)
        .with(address)
        .and_return(["zipcode", { address: "params" }])

      allow(dummy_client)
        .to receive(:rates_for_location)
        .with("zipcode", { address: "params" })
        .and_return({ some_kind_of: "response" })
    end

    it { is_expected.to eq({ some_kind_of: "response" }) }
  end

  describe "#create_transaction_for" do
    subject { api.create_transaction_for order }

    let(:api) { described_class.new(taxjar_client: dummy_client) }
    let(:dummy_client) { instance_double ::Taxjar::Client }
    let(:order) { Spree::Order.new }

    before do
      allow(SuperGood::SolidusTaxJar::APIParams)
        .to receive(:transaction_params)
        .with(order)
        .and_return({ transaction: "params" })

      allow(dummy_client)
        .to receive(:create_order)
        .with({ transaction: "params" })
        .and_return({ some_kind_of: "response" })
    end

    it { is_expected.to eq({ some_kind_of: "response" }) }
  end

  describe "#update_transaction_for" do
    subject { api.update_transaction_for order }

    let(:api) { described_class.new(taxjar_client: dummy_client) }
    let(:dummy_client) { instance_double ::Taxjar::Client }
    let(:order) { Spree::Order.new }

    before do
      allow(SuperGood::SolidusTaxJar::APIParams)
        .to receive(:transaction_params)
        .with(order)
        .and_return({ transaction: "params" })

      allow(dummy_client)
        .to receive(:update_order)
        .with({ transaction: "params" })
        .and_return({ some_kind_of: "response" })
    end

    it { is_expected.to eq({ some_kind_of: "response" }) }
  end

  describe "#update_transaction_for" do
    subject { api.delete_transaction_for order }

    let(:api) { described_class.new(taxjar_client: dummy_client) }
    let(:dummy_client) { instance_double ::Taxjar::Client }
    let(:order) { Spree::Order.new(number: "R111222333") }

    before do
      allow(dummy_client)
        .to receive(:delete_order)
        .with("R111222333")
        .and_return({ some_kind_of: "response" })
    end

    it { is_expected.to eq({ some_kind_of: "response" }) }
  end

  describe "#create_refund_for" do
    subject { api.create_refund_for reimbursement }

    let(:api) { described_class.new(taxjar_client: dummy_client) }
    let(:dummy_client) { instance_double ::Taxjar::Client }
    let(:reimbursement) { Spree::Reimbursement.new }

    before do
      allow(SuperGood::SolidusTaxJar::APIParams)
        .to receive(:refund_params)
        .with(reimbursement)
        .and_return({ refund: "params" })

      allow(dummy_client)
        .to receive(:create_refund)
        .with({ refund: "params" })
        .and_return({ some_kind_of: "response" })
    end

    it { is_expected.to eq({ some_kind_of: "response" }) }
  end
end
