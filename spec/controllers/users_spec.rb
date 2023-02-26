RSpec.describe UsersController, type: :controller do
  describe 'GET /index' do
    shared_examples 'a correct http code' do |code|
      before { get :index }
      it { expect(response).to have_http_status(code) }
    end

    context 'when user has admin role' do
      login_admin!
      it_behaves_like 'a correct http code', :success
    end
    context 'when user has moderator role' do
      login_user!
      it_behaves_like 'a correct http code', :redirect
    end
    context 'when user has not admin role' do
      login_user!
      it_behaves_like 'a correct http code', :redirect
    end
  end

  describe 'PUT /update' do
    let!(:actor) { create(:user) }
    context 'when user has admin role' do
      login_admin!
      it 'update user' do
        expect do
          put :update, params: { id: actor.id, user: { name: 'John' } }
        end.to change { actor.reload.name }.to('John')
        expect(response).to have_http_status(:redirect)
      end
      it 'fails' do
        expect do
          put :update, params: { id: actor.id, user: { name: '' } }
        end.to_not(change { actor.reload.name })
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not delete user' do
          expect do
            put :update, params: { id: actor.id, user: { name: 'John' } }
          end.to_not change(actor, :name)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'moderator' do
        login_moderator!
        it_behaves_like 'restricted access'
      end
      context 'normal user' do
        login_user!
        it_behaves_like 'restricted access'
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:actor) { create(:user) }
    context 'when user has admin role' do
      login_admin!
      it 'delete user' do
        expect do
          delete :destroy, params: { id: actor.id }
        end.to change(User, :count).by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not delete user' do
          expect do
            delete :destroy, params: { id: actor.id }
          end.to_not change(User, :count)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'moderator' do
        login_moderator!
        it_behaves_like 'restricted access'
      end
      context 'normal user' do
        login_user!
        it_behaves_like 'restricted access'
      end
    end
  end
end
