RSpec.shared_examples 'Votable' do |klass|
  it { should have_many(:votes).dependent(:destroy) }

  context 'concern methods' do
    let(:subject) { create described_class.to_s.downcase.to_sym }
    let(:user)    { create :user }

    it 'can be liked' do
      expect { subject.like(user) }.to change { subject.votes.count }.by(1)
    end

    it 'can be disliked' do
      expect { subject.dislike(user) }.to change { subject.votes.count }.by(1)
    end

    it 'can be recalled' do
      subject.like(user)
      expect { subject.recall(user) }.to change { subject.votes.count }.by(-1)
    end

    it 'calculates rating' do
      subject.like(user)
      expect(subject.rating).to be_equal(1)
    end

    it 'knows if voted' do
      subject.like(user)
      expect(subject.was_voted_by?(user)).to be true
    end

    it 'knows if not voted' do
      expect(subject.was_voted_by?(user)).to be false
    end
  end
end
