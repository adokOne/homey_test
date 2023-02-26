RSpec.describe ProjectsController, type: :controller do # rubocop:disable Metrics/BlockLength
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
      it_behaves_like 'a correct http code', :success
    end
    context 'when user has not admin role' do
      login_user!
      it_behaves_like 'a correct http code', :success
    end
  end

  describe 'GET /show' do
    let!(:project) { create(:project) }
    shared_examples 'a project viewer' do |_code|
      it 'not allow to create a project' do
        get :show, params: { id: project.id }
        expect(response).to have_http_status(:success)
      end
    end
    context 'admin' do
      login_admin!
      it_behaves_like 'a project viewer'
    end
    context 'moderator' do
      login_moderator!
      it_behaves_like 'a project viewer'
    end
    context 'normal user' do
      login_user!
      it_behaves_like 'a project viewer'
    end
  end

  describe 'GET /new' do
    context 'admin' do
      login_admin!
      it 'render correct template' do
        get :new
        expect(response).to have_http_status(:success)
        expect(response).to render_template('projects/new')
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not allow to create a project' do
          get :new
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

  describe 'GET /edit' do
    let!(:project) { create(:project) }
    context 'admin' do
      login_admin!
      it 'render correct template' do
        get :edit, params: { id: project.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template('projects/edit')
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not allow to create a project' do
          get :edit, params: { id: project.id }
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

  describe 'POST /create' do
    let!(:project) { create(:project) }
    context 'when user has admin role' do
      login_admin!
      context 'with correct params' do
        it 'create project' do
          expect do
            post :create, params: { project: { name: 'test project' } }
          end.to change(Project, :count).by(1)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'with incorrect params' do
        it 'fails' do
          expect do
            post :create, params: { project: { name: '' } }
          end.to_not change(Project, :count)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not allow to create a project' do
          expect do
            post :create, params: { project: { name: 'some project' } }
          end.to_not change(Project, :count)
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

  describe 'PUT /update' do
    let!(:project) { create(:project) }
    context 'when user has admin role' do
      login_admin!
      it 'update user' do
        expect do
          put :update, params: { id: project.id, project: { name: 'new name' } }
        end.to change { project.reload.name }.to('new name')
        expect(response).to have_http_status(:redirect)
      end
      it 'fails' do
        expect do
          put :update, params: { id: project.id, project: { name: '' } }
        end.to_not(change { project.reload.name })
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not delete user' do
          expect do
            put :update, params: { id: project.id, project: { name: 'new name' } }
          end.to_not change(project, :name)
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

  describe 'POST /change_status' do
    let!(:project) { create(:project) }
    shared_examples 'correct behaviour' do |_code|
      it 'update status and create status change record' do
        expect do
          post :change_status, params: { id: project.id, status: STATUS_COMPLETED }
        end.to change {
                 project.reload.status
               }.to('completed').and(change(project.reload.status_changes,
                                            :count).by(1)).and(change(project.activities, :count).by(1))
        expect(response).to have_http_status(:redirect)
      end
      it 'fails' do
        expect do
          post :change_status, params: { id: project.id, status: 100_500 }
        end.to_not(change { project.reload.status })
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'when user has admin role' do
      login_admin!
      it_behaves_like 'correct behaviour'
    end
    context 'when user has not admin role' do
      context 'moderator' do
        login_moderator!
        it_behaves_like 'correct behaviour'
      end
      context 'normal user' do
        login_user!
        it 'not delete user' do
          expect do
            post :change_status, params: { id: project.id, status: STATUS_COMPLETED }
          end.to_not change(project, :status)
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:project) { create(:project) }
    context 'when user has admin role' do
      login_admin!
      it 'delete project' do
        expect do
          delete :destroy, params: { id: project.id }
        end.to change(Project, :count).by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not delete project' do
          expect do
            delete :destroy, params: { id: project.id }
          end.to_not change(Project, :count)
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
