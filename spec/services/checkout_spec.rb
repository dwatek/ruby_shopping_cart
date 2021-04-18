# frozen_string_literal: true

RSpec.describe Checkout do
  subject(:checkout) { described_class.new(promotional_rules) }

  describe '#scan' do
    let!(:product) { create(:product, code: '001', name: 'Red Scarf', price: 9.25) }
    let(:promotional_rules) { [] }

    context 'when product exist' do
      it 'returns checkout products' do
        expect(checkout.scan('001')).to match_array [product]
      end
    end

    context 'when product does not exist' do
      it 'raise ActiveRecord::RecordNotFound' do
        expect { checkout.scan('004') }.to raise_error ActiveRecord::RecordNotFound, "Couldn't find Product"
      end
    end
  end

  describe '#total' do
    before do
      create(:promotion, promotion_type: 'product', product_code: '001', condition: 2, discount: 0.75)
      create(:promotion, promotion_type: 'checkout', condition: 60, discount: 10)

      create(:product, code: '001', name: 'Red Scarf', price: 9.25)
      create(:product, code: '002', name: 'Silver cufflinks', price: 45.00)
      create(:product, code: '003', name: 'Silk Dress', price: 19.95)

      codes.each { |code| checkout.scan(code) }
    end

    context 'when promotional_rules are empty' do
      let(:promotional_rules) { [] }

      context 'when products 001, 002, 001, 003' do
        let(:codes) { %w[001 002 001 003] }

        it { expect(checkout.total).to eq 83.45 }
      end
    end

    context 'when promotional_rules are checkout type' do
      let(:promotional_rules) { Promotion.where(promotion_type: 'checkout') }

      context 'when products 001, 002, 001, 003' do
        let(:codes) { %w[001 002 001 003] }

        it { expect(checkout.total).to eq 75.11 }
      end
    end

    context 'when promotional_rules are products type' do
      let(:promotional_rules) { Promotion.where(promotion_type: 'product') }

      context 'when products 001, 002, 001, 003' do
        let(:codes) { %w[001 002 001 003] }

        it { expect(checkout.total).to eq 81.95 }
      end
    end

    context 'when promotional_rules are products and checkout types' do
      let(:promotional_rules) { Promotion.all }

      context 'when products 001, 002, 003' do
        let(:codes) { %w[001 002 003] }

        it { expect(checkout.total).to eq 66.78 }
      end

      context 'when products 001, 003, 001' do
        let(:codes) { %w[001 003 001] }

        it { expect(checkout.total).to eq 36.95 }
      end

      context 'when products 001, 002, 001, 003' do
        let(:codes) { %w[001 002 001 003] }

        it { expect(checkout.total).to eq 73.76 }
      end
    end
  end
end
